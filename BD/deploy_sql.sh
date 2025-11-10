#!/usr/bin/env bash
set -euo pipefail

# ---------- CONFIG (ajusta si quieres) ----------
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"   # carpeta donde están Tablas/ y Procedures/
SQL_CONTAINER_NAME="${SQL_CONTAINER_NAME:-sqlserver}"
SA_PASSWORD="${SA_PASSWORD:-abc123***}"  # puedes exportar SA_PASSWORD antes de ejecutar para seguridad
WAIT_TIMEOUT="${WAIT_TIMEOUT:-300}"      # segundos máximos para esperar SQL Server
SLEEP_INTERVAL=5                         # segundos entre reintentos
# -------------------------------------------------

cd "$PROJECT_DIR" || { echo "No existe $PROJECT_DIR"; exit 1; }
echo "Proyecto: $PROJECT_DIR"

# Si no existe contenedor con el nombre esperado, intenta encontrar un contenedor que ejecute SQL Server
if ! docker ps --format '{{.Names}}' | grep -q -x "$SQL_CONTAINER_NAME"; then
  echo "No se encontró contenedor llamado '$SQL_CONTAINER_NAME'. Buscando contenedor con imagen del motor SQL..."
  candidate=$(docker ps --filter "ancestor=mcr.microsoft.com/mssql/server:2022-latest" --format "{{.Names}}" | head -n1 || true)
  if [ -n "$candidate" ]; then
    echo "Encontrado contenedor SQL: $candidate (usaré este nombre)"
    SQL_CONTAINER_NAME="$candidate"
  else
    # intenta buscar cualquier contenedor que parezca SQL Server (fallback)
    candidate2=$(docker ps --format "{{.Image}} {{.Names}}" | grep -i mssql | awk '{print $2}' | head -n1 || true)
    if [ -n "$candidate2" ]; then
      echo "Encontrado contenedor SQL por imagen: $candidate2 (usaré este nombre)"
      SQL_CONTAINER_NAME="$candidate2"
    else
      echo "ERROR: No se encontró ningún contenedor de SQL Server corriendo. Ejecuta el contenedor primero."; docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"; exit 1
    fi
  fi
fi

echo "Usando contenedor: $SQL_CONTAINER_NAME"

# Función para probar conexión con sqlcmd dentro del contenedor
try_sql() {
  docker exec --user root "$SQL_CONTAINER_NAME" /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SET NOCOUNT ON; SELECT 1;" -b >/dev/null 2>&1
}

# Esperar a que SQL Server responda
echo "Esperando a que SQL Server esté listo (timeout ${WAIT_TIMEOUT}s)..."
elapsed=0
until try_sql ; do
  if [ "$elapsed" -ge "$WAIT_TIMEOUT" ]; then
    echo
    echo "ERROR: Timeout esperando SQL Server (llevado ${elapsed}s)."
    echo "Comprueba 'docker logs $SQL_CONTAINER_NAME' para ver por qué el motor no arrancó."
    exit 2
  fi
  printf "."; sleep "$SLEEP_INTERVAL"
  elapsed=$(( elapsed + SLEEP_INTERVAL ))
done
echo
echo "SQL Server está listo."

# Helper: ejecutar un archivo .sql dentro del contenedor mostrando salida en consola
run_sql_file() {
  local file_path="$1"
  local fname
  fname=$(basename "$file_path")
  local remote="/tmp/$fname"

  echo
  echo "===> Ejecutando: $fname"

  # copiar al contenedor
  docker cp "$file_path" "$SQL_CONTAINER_NAME":"$remote"

  # ejecutar y mostrar salida (sqlcmd imprimirá errores en stderr)
  docker exec --user root "$SQL_CONTAINER_NAME" /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -i "$remote" -b
  rc=$?

  # limpiar
  docker exec --user root "$SQL_CONTAINER_NAME" rm -f "$remote" >/dev/null 2>&1 || true

  if [ $rc -ne 0 ]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "ERROR: el archivo $fname devolvió código de salida $rc. Abortando."
    echo "Revisa el procedimiento y vuelve a ejecutar."
    echo "Puedes ejecutar manualmente para más info:"
    echo "  docker cp $file_path $SQL_CONTAINER_NAME:/tmp/$fname"
    echo "  docker exec -it --user root $SQL_CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P '***' -i /tmp/$fname"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    return $rc
  fi
  echo "OK: $fname"
  return 0
}

# Ejecutar Tablas
if [ -d "$PROJECT_DIR/Tablas" ]; then
  echo
  echo "==== Ejecutando scripts en Tablas/ ===="
  for sql in "$PROJECT_DIR"/Tablas/*.sql; do
    [ -e "$sql" ] || { echo "No hay archivos en Tablas/"; break; }
    run_sql_file "$sql" || exit 3
  done
else
  echo "Carpeta Tablas/ no encontrada en $PROJECT_DIR. Saltando."
fi

# Ejecutar Procedures
if [ -d "$PROJECT_DIR/Procedures" ]; then
  echo
  echo "==== Ejecutando scripts en Procedures/ ===="
  for sql in "$PROJECT_DIR"/Procedures/*.sql; do
    [ -e "$sql" ] || { echo "No hay archivos en Procedures/"; break; }
    run_sql_file "$sql" || exit 4
  done
else
  echo "Carpeta Procedures/ no encontrada en $PROJECT_DIR. Saltando."
fi

echo
echo "✅ Todos los scripts ejecutados correctamente."
exit 0
