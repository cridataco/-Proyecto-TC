# Parámetros de conexión
$ServerInstance = "sqlserver"  
$DatabaseName = "1marchadev"  # Sin corchetes ni punto y coma
$SqlUser = "sa"
$SqlPassword = "abc123***"
$SqlContainer = "mcr.microsoft.com/mssql-tools"  # Imagen oficial de herramientas SQL

# Rutas locales de los scripts SQL
$Tablas = "./Tablas"
$Procedures = "./Procedures"

# Verifica si los archivos existen
if (!(Test-Path $Tablas) -or !(Test-Path $Procedures)) {
    Write-Host "Error: No se encontraron los archivos SQL en la ruta especificada." -ForegroundColor Red
    exit 1
}

# Limpiar contenedores previos
Write-Host "Limpiando contenedores previos..." -ForegroundColor Yellow
docker container prune -f | Out-Null

# ========== PASO 1: CREAR TABLAS ==========
Write-Host "`n=== CREANDO LA BASE DE DATOS Y TABLAS ===" -ForegroundColor Cyan
$SqlFiles = Get-ChildItem -Path $Tablas -Filter "*.sql" | Sort-Object Name

# Verifica si hay archivos SQL
if ($SqlFiles.Count -eq 0) {
    Write-Host "Error: No se encontraron archivos SQL en la ruta $Tablas" -ForegroundColor Red
    exit 1
}

Write-Host "Ejecutando scripts en master..." -ForegroundColor White
Write-Host "Se ejecutarán $($SqlFiles.Count) scripts de tablas..." -ForegroundColor White

$counter = 0
foreach ($File in $SqlFiles) {
    $counter++
    Write-Host "[$counter/$($SqlFiles.Count)] Ejecutando: $($File.Name)..." -ForegroundColor White
    
    # Obtener ruta absoluta
    $absolutePath = (Resolve-Path $File.FullName).Path
    
    # Ejecutar con límites de memoria y timeout - SIN especificar base de datos
    docker run --rm `
        --network mi_red_sql `
        --memory=512m `
        --memory-swap=512m `
        -v "${absolutePath}:/script.sql" `
        $SqlContainer /bin/bash -c `
        "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /script.sql -t 300"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error en la ejecución de $($File.Name) - Código: $LASTEXITCODE" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "  ✓ Completado exitosamente" -ForegroundColor Green
    
    # Pausa breve para evitar sobrecarga
    Start-Sleep -Milliseconds 500
    
    # Limpiar contenedores cada 5 scripts
    if ($counter % 5 -eq 0) {
        Write-Host "  Limpiando contenedores intermedios..." -ForegroundColor Yellow
        docker container prune -f | Out-Null
    }
}

Write-Host "`nTablas creadas exitosamente." -ForegroundColor Green

# Pausa entre fases
Write-Host "`n=== PAUSA ENTRE EJECUCIONES ===" -ForegroundColor Cyan
Start-Sleep -Seconds 3

# ========== PASO 2: CREAR PROCEDIMIENTOS ==========
Write-Host "`n=== CREANDO PROCEDIMIENTOS ALMACENADOS ===" -ForegroundColor Cyan
$SqlFiles = Get-ChildItem -Path $Procedures -Filter "*.sql" | Sort-Object Name

# Verifica si hay archivos SQL
if ($SqlFiles.Count -eq 0) {
    Write-Host "Advertencia: No se encontraron archivos SQL en la ruta $Procedures" -ForegroundColor Yellow
} else {
    Write-Host "Ejecutando scripts en master..." -ForegroundColor White
    Write-Host "Se ejecutarán $($SqlFiles.Count) scripts de procedimientos..." -ForegroundColor White
    
    $counter = 0
    foreach ($File in $SqlFiles) {
        $counter++
        Write-Host "[$counter/$($SqlFiles.Count)] Ejecutando: $($File.Name)..." -ForegroundColor White
        
        # Obtener ruta absoluta
        $absolutePath = (Resolve-Path $File.FullName).Path
        
        # Ejecutar con límites de memoria y timeout - SIN especificar base de datos
        docker run --rm `
            --network mi_red_sql `
            --memory=512m `
            --memory-swap=512m `
            -v "${absolutePath}:/script.sql" `
            $SqlContainer /bin/bash -c `
            "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P '$SqlPassword' -i /script.sql -t 300"
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Error en la ejecución de $($File.Name) - Código: $LASTEXITCODE" -ForegroundColor Red
            exit 1
        }
        
        Write-Host "  ✓ Completado exitosamente" -ForegroundColor Green
        
        # Pausa breve para evitar sobrecarga
        Start-Sleep -Milliseconds 500
        
        # Limpiar contenedores cada 5 scripts
        if ($counter % 5 -eq 0) {
            Write-Host "  Limpiando contenedores intermedios..." -ForegroundColor Yellow
            docker container prune -f | Out-Null
        }
    }
    
    Write-Host "`nProcedimientos creados exitosamente." -ForegroundColor Green
}

# Limpieza final
Write-Host "`nLimpiando contenedores finales..." -ForegroundColor Yellow
docker container prune -f | Out-Null

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "✓ Base de datos y tablas creadas exitosamente en SQL Server." -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Green