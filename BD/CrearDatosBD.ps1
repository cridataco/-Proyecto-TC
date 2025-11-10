# CrearDatosBD_fixed.ps1 (corregido)
param(
    [string]$ServerInstance = "sqlserver",
    [string]$SqlUser = "sa",
    [string]$SqlPassword = "abc123***",
    [string]$Tablas = "./Tablas",
    [string]$Procedures = "./Procedures",
    [int]$WaitTimeoutSeconds = 300,
    [int]$SleepSeconds = 5
)

function WriteErr([string]$m){ Write-Host $m -ForegroundColor Red }
function WriteOk([string]$m){ Write-Host $m -ForegroundColor Green }

# 0) Docker check
try {
    & docker --version > $null 2>&1
} catch {
    WriteErr "ERROR: Docker no está disponible en este host. Salir."
    exit 1
}

# 1) Encontrar contenedor SQL
$containerName = $ServerInstance
$names = (& docker ps --format "{{.Names}}")
if (-not ($names -contains $containerName)) {
    Write-Host "No existe contenedor con nombre '$containerName'. Buscando candidato por imagen..."
    $candidate = (& docker ps --format "{{.Image}} {{.Names}}" | Select-String -Pattern "mssql|sqlserver" | ForEach-Object { ($_ -split " ",2)[1] }) | Select-Object -First 1
    if ([string]::IsNullOrEmpty($candidate)) {
        WriteErr "No se encontró contenedor SQL Server corriendo. Ejecuta el contenedor primero."
        & docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
        exit 1
    } else {
        $containerName = $candidate
        WriteHost "Usaré el contenedor encontrado: $containerName"
    }
} else {
    WriteHost "Contenedor encontrado: $containerName"
}

# 2) Función para probar sqlcmd dentro del contenedor (si existe)
function TrySqlCmd() {
    # intenta ejecutar SELECT 1 dentro del contenedor usando sqlcmd si está instalado
    $cmd = "docker exec --user root $containerName bash -c '/opt/mssql-tools/bin/sqlcmd -S localhost -U $SqlUser -P `"$SqlPassword`" -Q ""SET NOCOUNT ON; SELECT 1;"" -b'"
    $out = & bash -c $cmd 2>$null
    return $LASTEXITCODE
}

# Esperar sqlserver listo (siempre mostramos puntos)
Write-Host "Esperando a que SQL Server esté listo (timeout $WaitTimeoutSeconds s)..."
$elapsed = 0
while ($true) {
    $rc = TrySqlCmd
    if ($rc -eq 0) { WriteOk "SQL Server responde (sqlcmd disponible dentro del contenedor)."; break }
    if ($elapsed -ge $WaitTimeoutSeconds) {
        WriteErr "`nERROR: Timeout esperando SQL Server (llevado $elapsed s)."
        WriteHost "Mira 'docker logs $containerName --tail 50' para diagnosticar."
        break
    }
    Write-Host -NoNewline "."
    Start-Sleep -Seconds $SleepSeconds
    $elapsed += $SleepSeconds
}

# 3) Verificar existencia de sqlcmd dentro (función)
function SqlCmdExistsInside {
    $check = "docker exec --user root $containerName bash -c 'test -x /opt/mssql-tools/bin/sqlcmd && echo OK || echo NO'"
    $out = & bash -c $check 2>$null
    if ($out -ne $null) { $out = $out.Trim() }
    return ($out -eq "OK")
}

if (-not (SqlCmdExistsInside)) {
    WriteHost "`nsqlcmd NO está dentro del contenedor. Intentaremos instalar mssql-tools dentro del contenedor (si tiene apt)."
    # Verificar apt
    $hasAptCmd = "docker exec --user root $containerName bash -c 'command -v apt-get >/dev/null 2>&1 && echo APT || echo NO'"
    $hasApt = (& bash -c $hasAptCmd).Trim()
    if ($hasApt -ne "APT") {
        WriteErr "Este contenedor no tiene apt-get disponible. No puedo instalar mssql-tools dentro. Alternativas:"
        WriteHost " - Instalar mssql-tools en el host (preferible)"
        WriteHost " - Usar una imagen mssql-tools externa (pero puede fallar por libssl)"
        exit 10
    }

    # Crear here-string (sin indentación) con script de instalación
@'
set -e
apt-get update -y
apt-get install -y curl apt-transport-https gnupg ca-certificates lsb-release software-properties-common
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update -y
ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
ACCEPT_EULA=Y apt-get install -y mssql-tools
chmod +x /opt/mssql-tools/bin/sqlcmd
'@ > /tmp/install_mssql_tools.sh

    # Copiar instalador al contenedor (usar ${} para separar variable del ':')
    $tmpHostPath = "/tmp/install_mssql_tools.sh"
    & docker cp $tmpHostPath "${containerName}:/tmp/install_mssql_tools.sh"

    WriteHost "Ejecutando instalador dentro del contenedor... (salida mostrada)"
    & docker exec --user root -i $containerName bash -c "bash /tmp/install_mssql_tools.sh"
    if (-not (SqlCmdExistsInside)) {
        WriteErr "La instalación falló o sqlcmd sigue sin estar disponible. Mira 'docker logs $containerName' y la salida anterior."
        exit 11
    } else {
        WriteOk "sqlcmd instalado correctamente dentro del contenedor."
    }
} else {
    WriteOk "sqlcmd ya está dentro del contenedor."
}

# 4) Función para ejecutar archivo SQL (copiar y ejecutar mostrando salida)
function Run-SqlFileInsideContainer([string]$filePath) {
    if (-not (Test-Path $filePath)) {
        WriteErr "Archivo no encontrado: $filePath"
        return 2
    }
    $base = [System.IO.Path]::GetFileName($filePath)
    $remote = "/tmp/$base"

    WriteHost "`n===> Ejecutando: $base"

    & docker cp $filePath "${containerName}:$remote"
    # ejecutar mostrando salida
    & docker exec --user root -i $containerName /opt/mssql-tools/bin/sqlcmd -S localhost -U $SqlUser -P "$SqlPassword" -i $remote -b
    $rc = $LASTEXITCODE

    # limpiar
    & docker exec --user root $containerName bash -c "rm -f $remote" > $null 2>&1

    if ($rc -ne 0) {
        WriteErr "ERROR: ejecución de $base devolvió código $rc."
        return $rc
    } else {
        WriteOk "OK: $base"
        return 0
    }
}

# 5) Ejecutar Tablas
if (-not (Test-Path $Tablas)) { WriteErr "No se encontró carpeta Tablas ($Tablas)." }
else {
    $files = Get-ChildItem -Path $Tablas -Filter "*.sql" | Sort-Object Name
    foreach ($f in $files) {
        $r = Run-SqlFileInsideContainer $f.FullName
        if ($r -ne 0) { WriteErr "Abortando por error en $($f.Name)"; exit 20 }
    }
}

# 6) Ejecutar Procedures
if (-not (Test-Path $Procedures)) { WriteErr "No se encontró carpeta Procedures ($Procedures)." }
else {
    $files = Get-ChildItem -Path $Procedures -Filter "*.sql" | Sort-Object Name
    foreach ($f in $files) {
        $r = Run-SqlFileInsideContainer $f.FullName
        if ($r -ne 0) { WriteErr "Abortando por error en $($f.Name)"; exit 21 }
    }
}

WriteOk "`nTodos los scripts ejecutados correctamente."
exit 0
