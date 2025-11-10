# CrearDatosBD_fixed.ps1
# Ejecutar desde PowerShell en la EC2: pwsh ./CrearDatosBD_fixed.ps1
# Usa las mismas credenciales que indicaste.

param(
    [string]$ServerInstance = "sqlserver",
    [string]$SqlUser = "sa",
    [string]$SqlPassword = "abc123***",
    [string]$Tablas = "./Tablas",
    [string]$Procedures = "./Procedures",
    [int]$WaitTimeoutSeconds = 300,
    [int]$SleepSeconds = 5
)

function WriteErr($msg) { Write-Host $msg -ForegroundColor Red }
function WriteOk($msg)  { Write-Host $msg -ForegroundColor Green }

# 0) Pre-check: docker existe?
try {
    docker --version > $null 2>&1
} catch {
    WriteErr "ERROR: Docker no está disponible en este host. Salir."
    exit 1
}

# 1) encontrar contenedor sqlserver (por nombre o por imagen)
$containerName = $ServerInstance
$exists = (docker ps --format "{{.Names}}" | Select-String -Pattern "^$containerName$")

if (-not $exists) {
    Write-Host "No se encontró contenedor exactamente llamado '$containerName'. Buscando cualquiera que parezca SQL Server..."
    $candidate = docker ps --format "{{.Image}} {{.Names}}" | Select-String -Pattern "mssql|sqlserver" | ForEach-Object {
        $_.ToString().Split(" ",2)[1]
    } | Select-Object -First 1

    if ($null -eq $candidate -or $candidate -eq "") {
        WriteErr "ERROR: No se encontró un contenedor de SQL Server corriendo. Inicia el contenedor 'sqlserver' y vuelve a ejecutar."
        docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
        exit 1
    } else {
        $containerName = $candidate
        WriteHost "Usaré el contenedor encontrado: $containerName"
    }
} else {
    WriteHost "Contenedor encontrado: $containerName"
}

# 2) esperar a que SQL Server responda (tratamos con sqlcmd si está disponible)
$elapsed = 0
function TrySqlQuery()
{
    # Intentamos ejecutar sqlcmd dentro del contenedor si existe
    $checkCmd = "docker exec --user root $containerName bash -c ""/opt/mssql-tools/bin/sqlcmd -S localhost -U $SqlUser -P '$SqlPassword' -Q 'SET NOCOUNT ON; SELECT 1;' -b"" 2>$null"
    $res = Invoke-Expression $checkCmd 2>$null
    return $LASTEXITCODE
}

Write-Host "Esperando a que SQL Server esté listo (timeout $WaitTimeoutSeconds s)..."
while ($true) {
    $rc = TrySqlQuery
    if ($rc -eq 0) { WriteOk "SQL Server responde con sqlcmd."; break }
    if ($elapsed -ge $WaitTimeoutSeconds) {
        WriteErr "`nERROR: Timeout esperando SQL Server (llevado $elapsed s)."
        Write-Host "Comprobar logs del contenedor: docker logs $containerName --tail 50"
        break
    }
    Write-Host -NoNewline "."
    Start-Sleep -Seconds $SleepSeconds
    $elapsed += $SleepSeconds
}

# 3) Si sqlcmd no existe dentro del contenedor, intentamos instalar mssql-tools dentro del contenedor (solo si apt existe)
function SqlCmdExistsInside() {
    $cmd = "docker exec --user root $containerName bash -c 'test -x /opt/mssql-tools/bin/sqlcmd && echo OK || echo NO'"
    $out = (Invoke-Expression $cmd).Trim()
    return ($out -eq "OK")
}

if (-not (SqlCmdExistsInside())) {
    WriteHost "`nNo se encontró sqlcmd dentro del contenedor. Intentando instalar mssql-tools dentro del contenedor (esto requiere apt y conexión a Internet en el contenedor)."
    WriteHost "Si NO querés instalación en el contenedor, cancela (Ctrl+C) y te doy alternativa."
    Start-Sleep -Seconds 1

    # Intentamos detectar gestor de paquetes (apt)
    $hasApt = $false
    try {
        $testApt = docker exec --user root $containerName bash -c "command -v apt-get >/dev/null 2>&1 && echo APT || echo NO"
        if ($testApt -match "APT") { $hasApt = $true }
    } catch { $hasApt = $false }

    if (-not $hasApt) {
        WriteErr "ERROR: Este contenedor no tiene apt-get disponible. No puedo instalar mssql-tools dentro. Alternativa: instala mssql-tools en el host o usa otra imagen de herramientas."
        exit 10
    }

    WriteHost "Instalando dependencias y mssql-tools dentro del contenedor (esto puede tardar)."
    $installScript = @"
set -e
apt-get update -y
apt-get install -y curl apt-transport-https gnupg ca-certificates lsb-release software-properties-common
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update -y
ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
ACCEPT_EULA=Y apt-get install -y mssql-tools
chmod +x /opt/mssql-tools/bin/sqlcmd
"@

    # Guardar script temporal en host y copiar
    $tmpHostPath = [System.IO.Path]::Combine($env:TEMP, "install_mssql_tools.sh")
    Set-Content -Path $tmpHostPath -Value $installScript -Encoding UTF8
    docker cp $tmpHostPath $containerName:/tmp/install_mssql_tools.sh
    Remove-Item $tmpHostPath -Force

    WriteHost "Ejecutando instalador dentro del contenedor (ver salida)..."
    $runInstall = "docker exec --user root -i $containerName bash -c 'bash /tmp/install_mssql_tools.sh'"
    try {
        Invoke-Expression $runInstall
    } catch {
        WriteErr "La instalación dentro del contenedor falló. Revisa la salida anterior. Alternativa: instala mssql-tools en el host o usa otra imagen de herramientas."
        exit 11
    }

    # verificar ahora
    if (-not (SqlCmdExistsInside())) {
        WriteErr "Después de la instalación, sqlcmd sigue sin estar disponible. Abortando."
        exit 12
    } else {
        WriteOk "sqlcmd instalado correctamente dentro del contenedor."
    }
} else {
    WriteOk "sqlcmd ya existe dentro del contenedor."
}

# 4) Función para ejecutar un archivo .sql (copia al contenedor y ejecuta)
function Run-SqlFileInsideContainer([string]$filePath) {
    if (-not (Test-Path $filePath)) {
        WriteErr "Archivo no encontrado: $filePath"
        return 2
    }
    $base = [System.IO.Path]::GetFileName($filePath)
    $remote = "/tmp/$base"

    WriteHost "`n==> Ejecutando $base ..."
    docker cp $filePath "$containerName:$remote" | Out-Null

    # Ejecutar sqlcmd dentro del contenedor y mostrar salida en vivo
    $invoke = "docker exec --user root -i $containerName bash -c '/opt/mssql-tools/bin/sqlcmd -S localhost -U $SqlUser -P `"$SqlPassword`" -i $remote -b'"
    $proc = Start-Process -FilePath "bash" -ArgumentList "-lc", $invoke -NoNewWindow -Wait -PassThru
    $rc = $proc.ExitCode

    # borrar archivo remoto
    docker exec --user root $containerName bash -c "rm -f $remote" > $null 2>&1

    if ($rc -ne 0) {
        WriteErr "ERROR: ejecución de $base devolvió código $rc."
        return $rc
    } else {
        WriteOk "OK: $base"
        return 0
    }
}

# 5) Ejecutar Tablas
if (-not (Test-Path $Tablas)) {
    WriteErr "No se encontró la carpeta Tablas ($Tablas)."
} else {
    $files = Get-ChildItem -Path $Tablas -Filter "*.sql" | Sort-Object Name
    if ($files.Count -eq 0) { WriteHost "No hay archivos .sql en Tablas." }
    foreach ($f in $files) {
        $rc = Run-SqlFileInsideContainer $f.FullName
        if ($rc -ne 0) { WriteErr "Abortando debido a error en $($f.Name)."; exit 20 }
    }
}

# 6) Ejecutar Procedures
if (-not (Test-Path $Procedures)) {
    WriteErr "No se encontró la carpeta Procedures ($Procedures)."
} else {
    $files = Get-ChildItem -Path $Procedures -Filter "*.sql" | Sort-Object Name
    if ($files.Count -eq 0) { WriteHost "No hay archivos .sql en Procedures." }
    foreach ($f in $files) {
        $rc = Run-SqlFileInsideContainer $f.FullName
        if ($rc -ne 0) { WriteErr "Abortando debido a error en $($f.Name)."; exit 21 }
    }
}

WriteOk "`nBase de datos y objetos ejecutados correctamente."
exit 0
