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

Write-Host "=== LIMPIANDO BASE DE DATOS EXISTENTE ===" -ForegroundColor Yellow

# Script para limpiar la base de datos
$CleanupScript = @"
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'$DatabaseName')
BEGIN
    ALTER DATABASE [$DatabaseName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$DatabaseName];
END
GO

CREATE DATABASE [$DatabaseName];
GO
"@

# Guardar script de limpieza temporalmente
$CleanupFile = "./cleanup_temp.sql"
$CleanupScript | Out-File -FilePath $CleanupFile -Encoding UTF8

# Ejecutar limpieza
Write-Host "Eliminando y recreando la base de datos..." -ForegroundColor Yellow
docker run --rm --network mi_red_sql -v "$(Resolve-Path $CleanupFile):/cleanup.sql" $SqlContainer /bin/bash -c `
    "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /cleanup.sql"

# Eliminar archivo temporal
Remove-Item $CleanupFile -Force

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error al limpiar la base de datos" -ForegroundColor Red
    exit 1
}

Write-Host "Base de datos limpia y lista." -ForegroundColor Green
Start-Sleep -Seconds 2

# ========== CREAR TABLAS ==========
Write-Host "`n=== CREANDO TABLAS ===" -ForegroundColor Cyan
$SqlFiles = Get-ChildItem -Path $Tablas -Filter "*.sql" | Sort-Object Name

if ($SqlFiles.Count -eq 0) {
    Write-Host "Error: No se encontraron archivos SQL en $Tablas" -ForegroundColor Red
    exit 1
}

foreach ($File in $SqlFiles) {
    Write-Host "Ejecutando: $($File.Name)..." -ForegroundColor White
    
    docker run --rm --network mi_red_sql -v "$($File.FullName):/script.sql" $SqlContainer /bin/bash -c `
        "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /script.sql"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error en $($File.Name)" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Tablas creadas." -ForegroundColor Green

# ========== CREAR PROCEDIMIENTOS ==========
Write-Host "`n=== CREANDO PROCEDIMIENTOS ===" -ForegroundColor Cyan
$SqlFiles = Get-ChildItem -Path $Procedures -Filter "*.sql" | Sort-Object Name

if ($SqlFiles.Count -eq 0) {
    Write-Host "No hay procedimientos para crear." -ForegroundColor Yellow
} else {
    foreach ($File in $SqlFiles) {
        Write-Host "Ejecutando: $($File.Name)..." -ForegroundColor White
        
        docker run --rm --network mi_red_sql -v "$($File.FullName):/script.sql" $SqlContainer /bin/bash -c `
            "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /script.sql"
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Error en $($File.Name)" -ForegroundColor Red
            exit 1
        }
    }
    
    Write-Host "Procedimientos creados." -ForegroundColor Green
}

Write-Host "`n✓ PROCESO COMPLETADO" -ForegroundColor Green