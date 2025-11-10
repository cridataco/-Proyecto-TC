# Par metros de conexi n
$ServerInstance = "sqlserver"  
$DatabaseName = "[1marchadev];"
$SqlUser = "sa"
$SqlPassword = "abc123***"
$SqlContainer = "mcr.microsoft.com/mssql-tools18"  # Imagen oficial de herramientas SQL

# Rutas locales de los scripts SQL
$Tablas = "./Tablas"

$Procedures = "./Procedures"


# Verifica si los archivos existen
if (!(Test-Path $Tablas) -or !(Test-Path $Procedures)) {
    Write-Host "Error: No se encontraron los archivos SQL en la ruta especificada." -ForegroundColor Red
    exit 1
}

# Ejecutar script de creaci n de la base de datos y tablas
Write-Host "Creando la base de datos y tablas..."
$SqlFiles = Get-ChildItem -Path $Tablas -Filter "*.sql" | Sort-Object Name  # Ordena los scripts por nombre

 
# Verifica si hay archivos SQL
if ($SqlFiles.Count -eq 0) {
    Write-Host "Error: No se encontraron archivos SQL en la ruta $ScriptPath" -ForegroundColor Red
    exit 1
}

# Ejecutar scripts en la base de datos master (para creaci n de BD)
Write-Host "Ejecutando scripts en master..."
foreach ($File in $SqlFiles) {
    Write-Host "Ejecutando: $($File.Name)..."
    docker run --rm --network mi_red_sql -v "$($File.FullName):/script.sql" $SqlContainer /bin/bash -c `
        "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P $SqlPassword -i /script.sql"

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error en la ejecuci n de $($File.Name)" -ForegroundColor Red
        exit 1
    }
}


# Ejecutar script de creaci n de procedimientos almacenados
Write-Host "Creando los Procedures..."
$SqlFiles = Get-ChildItem -Path $Procedures -Filter "*.sql" | Sort-Object Name  # Ordena los scripts por nombre

# Ejecutar scripts en la base de datos master (para creaci n de BD)
Write-Host "Ejecutando scripts en master..."
foreach ($File in $SqlFiles) {
    Write-Host "Ejecutando: $($File.Name)..."
    docker run --rm --network mi_red_sql -v "$($File.FullName):/script.sql" $SqlContainer /bin/bash -c `
        "/opt/mssql-tools/bin/sqlcmd -S $ServerInstance -U $SqlUser -P $SqlPassword -i /script.sql"

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error en la ejecuci n de $($File.Name)" -ForegroundColor Red
        exit 1
    }
}




Write-Host "Base de datos y tablas creadas exitosamente en SQL Server." -ForegroundColor Green
