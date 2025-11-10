# Parámetros de conexión
$ServerInstance = "sqlserver"  
$DatabaseName = "1marchadev"
$SqlUser = "sa"
$SqlPassword = "abc123***"
$SqlContainer = "mcr.microsoft.com/mssql-tools"

# Rutas locales de los scripts SQL
$Tablas = "./Tablas"
$Procedures = "./Procedures"

# Verifica si los archivos existen
if (!(Test-Path $Tablas) -or !(Test-Path $Procedures)) {
    Write-Host "Error: No se encontraron los archivos SQL en la ruta especificada." -ForegroundColor Red
    exit 1
}

Write-Host "=== LIMPIANDO BASE DE DATOS COMPLETA ===" -ForegroundColor Yellow

# Script para limpiar TODO (tablas, procedimientos, funciones, vistas)
$CleanupScript = @"
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'$DatabaseName')
BEGIN
    ALTER DATABASE [$DatabaseName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$DatabaseName];
    PRINT 'Base de datos eliminada';
END
GO

CREATE DATABASE [$DatabaseName];
GO

PRINT 'Base de datos creada exitosamente';
GO
"@

# Guardar script de limpieza temporalmente
$CleanupFile = "./cleanup_temp.sql"
$CleanupScript | Out-File -FilePath $CleanupFile -Encoding UTF8

# Ejecutar limpieza
Write-Host "Eliminando y recreando la base de datos limpia..." -ForegroundColor Yellow
docker run --rm --network mi_red_sql -v "$(Resolve-Path $CleanupFile):/cleanup.sql" $SqlContainer /bin/bash -c `
    "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /cleanup.sql"

# Eliminar archivo temporal
Remove-Item $CleanupFile -Force -ErrorAction SilentlyContinue

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error al limpiar la base de datos" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Base de datos limpia y lista." -ForegroundColor Green
Start-Sleep -Seconds 2

# ========== CREAR TABLAS ==========
Write-Host "`n=== CREANDO TABLAS ===" -ForegroundColor Cyan
$SqlFiles = Get-ChildItem -Path $Tablas -Filter "*.sql" | Sort-Object Name

if ($SqlFiles.Count -eq 0) {
    Write-Host "Error: No se encontraron archivos SQL en $Tablas" -ForegroundColor Red
    exit 1
}

Write-Host "Total de scripts de tablas: $($SqlFiles.Count)" -ForegroundColor White

$counter = 0
$errores = @()

foreach ($File in $SqlFiles) {
    $counter++
    Write-Host "[$counter/$($SqlFiles.Count)] Ejecutando: $($File.Name)..." -ForegroundColor White
    
    docker run --rm --network mi_red_sql -v "$($File.FullName):/script.sql" $SqlContainer /bin/bash -c `
        "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /script.sql"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  ✗ Error en $($File.Name)" -ForegroundColor Red
        $errores += "TABLA: $($File.Name)"
    } else {
        Write-Host "  ✓ Completado" -ForegroundColor Green
    }
}

if ($errores.Count -eq 0) {
    Write-Host "`n✓ Todas las tablas creadas exitosamente." -ForegroundColor Green
} else {
    Write-Host "`n⚠ Tablas con errores: $($errores.Count)" -ForegroundColor Yellow
}

Start-Sleep -Seconds 2

# ========== CREAR PROCEDIMIENTOS ==========
Write-Host "`n=== CREANDO PROCEDIMIENTOS ===" -ForegroundColor Cyan
$SqlFiles = Get-ChildItem -Path $Procedures -Filter "*.sql" | Sort-Object Name

if ($SqlFiles.Count -eq 0) {
    Write-Host "No hay procedimientos para crear." -ForegroundColor Yellow
} else {
    Write-Host "Total de procedimientos: $($SqlFiles.Count)" -ForegroundColor White
    
    $counter = 0
    
    foreach ($File in $SqlFiles) {
        $counter++
        Write-Host "[$counter/$($SqlFiles.Count)] Ejecutando: $($File.Name)..." -ForegroundColor White
        
        docker run --rm --network mi_red_sql -v "$($File.FullName):/script.sql" $SqlContainer /bin/bash -c `
            "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /script.sql"
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ✗ Error en $($File.Name)" -ForegroundColor Red
            $errores += "PROCEDURE: $($File.Name)"
        } else {
            Write-Host "  ✓ Completado" -ForegroundColor Green
        }
    }
    
    if ($errores.Count -eq 0) {
        Write-Host "`n✓ Todos los procedimientos creados exitosamente." -ForegroundColor Green
    }
}

# ========== RESUMEN FINAL ==========
Write-Host "`n========================================" -ForegroundColor Cyan
if ($errores.Count -eq 0) {
    Write-Host "✓ PROCESO COMPLETADO SIN ERRORES" -ForegroundColor Green
} else {
    Write-Host "⚠ PROCESO COMPLETADO CON $($errores.Count) ERRORES" -ForegroundColor Yellow
    Write-Host "`nArchivos con errores:" -ForegroundColor Yellow
    foreach ($error in $errores) {
        Write-Host "  - $error" -ForegroundColor Red
    }
}
Write-Host "========================================`n" -ForegroundColor Cyan