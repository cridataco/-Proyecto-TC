# Parámetros de conexión
$ServerInstance = "sqlserver"  
$SqlUser = "sa"
$SqlPassword = "abc123***"
$SqlContainer = "mcr.microsoft.com/mssql-tools"

# Ruta de procedimientos
$Procedures = "./Procedures"

# Verifica si existe la carpeta
if (!(Test-Path $Procedures)) {
    Write-Host "Error: No se encontró la carpeta de procedimientos." -ForegroundColor Red
    exit 1
}

Write-Host "=== CONTINUANDO CREACIÓN DE PROCEDIMIENTOS ===" -ForegroundColor Cyan

# CAMBIAR AQUÍ: Último archivo que se intentó ejecutar antes del crash
$archivoUltimoIntento = "pagos_paymentId_actualizar.sql"

Write-Host "Buscando desde: $archivoUltimoIntento" -ForegroundColor Yellow

# Obtener TODOS los procedimientos ordenados
$TodosLosProcedimientos = Get-ChildItem -Path $Procedures -Filter "*.sql" | Sort-Object Name

# Encontrar el índice del archivo donde quedó
$indiceInicio = 0
for ($i = 0; $i -lt $TodosLosProcedimientos.Count; $i++) {
    if ($TodosLosProcedimientos[$i].Name -eq $archivoUltimoIntento) {
        $indiceInicio = $i + 1  # Empezar desde el SIGUIENTE
        break
    }
}

if ($indiceInicio -eq 0) {
    Write-Host "No se encontró el archivo de referencia. Ejecutando todos..." -ForegroundColor Yellow
    $SqlFiles = $TodosLosProcedimientos
} else {
    # Tomar solo los archivos DESPUÉS del que falló
    $SqlFiles = $TodosLosProcedimientos[$indiceInicio..($TodosLosProcedimientos.Count - 1)]
    Write-Host "Se encontró. Continuando desde el archivo #$($indiceInicio + 1)" -ForegroundColor Green
}

$totalFaltantes = $SqlFiles.Count
Write-Host "Procedimientos faltantes: $totalFaltantes" -ForegroundColor White
Write-Host "========================================`n" -ForegroundColor Cyan

if ($totalFaltantes -eq 0) {
    Write-Host "✓ No hay procedimientos pendientes. ¡TODOS COMPLETADOS!" -ForegroundColor Green
    exit 0
}

# Mostrar lista de procedimientos a ejecutar
Write-Host "Archivos a ejecutar:" -ForegroundColor Cyan
$SqlFiles | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor White }
Write-Host ""

$continuar = Read-Host "¿Continuar con la ejecución? (S/N)"
if ($continuar -ne "S") {
    Write-Host "Cancelado por el usuario." -ForegroundColor Yellow
    exit 0
}

Write-Host "`nIniciando ejecución...`n" -ForegroundColor Green

# Ejecutar procedimientos faltantes
$counter = 0
$errores = @()

foreach ($File in $SqlFiles) {
    $counter++
    Write-Host "[$counter/$totalFaltantes] Ejecutando: $($File.Name)..." -ForegroundColor White
    
    docker run --rm --network mi_red_sql -v "$($File.FullName):/script.sql" $SqlContainer /bin/bash -c `
        "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /script.sql"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ✗ Error en $($File.Name)" -ForegroundColor Red
        $errores += $File.Name
        
        # Preguntar si continuar
        $respuesta = Read-Host "  ¿Continuar con el siguiente? (S/N)"
        if ($respuesta -ne "S") {
            Write-Host "`nProceso detenido por el usuario." -ForegroundColor Yellow
            Write-Host "Último archivo intentado: $($File.Name)" -ForegroundColor Yellow
            Write-Host "Para continuar, cambia la variable a: `$archivoUltimoIntento = `"$($File.Name)`"" -ForegroundColor Cyan
            break
        }
    } else {
        Write-Host "  ✓ Completado" -ForegroundColor Green
    }
    
    # Pausa breve entre ejecuciones
    Start-Sleep -Milliseconds 300
}

# Resumen final
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "RESUMEN DE EJECUCIÓN" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total ejecutados: $counter de $totalFaltantes" -ForegroundColor White

if ($errores.Count -eq 0) {
    Write-Host "✓ TODOS LOS PROCEDIMIENTOS CREADOS EXITOSAMENTE" -ForegroundColor Green
} else {
    Write-Host "⚠ Errores encontrados: $($errores.Count)" -ForegroundColor Yellow
    Write-Host "`nArchivos con errores:" -ForegroundColor Yellow
    foreach ($error in $errores) {
        Write-Host "  - $error" -ForegroundColor Red
    }
}
Write-Host "========================================`n" -ForegroundColor Cyan