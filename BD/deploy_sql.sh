#!/usr/bin/env bash
set -euo pipefail

# -------------------------
# CONFIGURACIÓN (ajusta si es necesario)
# -------------------------
PROJECT_DIR="${PROJECT_DIR:-$(pwd)}"   # carpeta donde están Tablas/ y Procedures/
SQL_CONTAINER_NAME="${SQL_CONTAINER_NAME:-sqlserver}"
SA_PASSWORD="${SA_PASSWORD:-abc123***}"  # mejor: exportar SA_PASSWORD antes de ejecutar
WAIT_TIMEOUT="${WAIT_TIMEOUT:-300}"      # segundos máximos para esperar SQL Server
LOG_DIR="${PROJECT_DIR}/logs_sql"        # logs por archivo SQL
# -------------------------

mkdir -p "$LOG_DIR"

echo "Proyecto: $PROJECT_DIR"
echo "Contenedor SQL: $SQL_CONTAINER_NAME"
echo "Logs en: $LOG_DIR"

# 1) Verificar que el contenedor exista
if ! docker ps --format '{{.Names}}' | grep -q -x "$SQL_CONTAINER_NAME"; then
  echo "ERROR: No se encontró un contenedor corriendo llamado '$SQL_CONTAINER_NAME'."
  echo "Listado de contenedores activos:"
  docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
  exit 1
fi

# 2) Esperar a que SQL Server responda con SELECT 1
echo "Esperando a que SQL Server esté listo (timeout ${WAIT_TIMEOUT}s)..."
SECS_WAITED=0
while true; do
  if docker exec --user root "$SQL_CONTAINER_NAME" /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SET NOCOUNT ON; SELECT 1;" -b >/dev/null 2>&1; then
    echo "SQL Server responde."
    break
  fi
  sleep 5
  SECS_WAITED=$((SECS_WAITED+5))
  echo -n "."
  if [ "$SECS_WAITED" -ge "$WAIT_TIMEOUT" ]; then
    echo
    echo "ERROR: Timeout esperando SQL Server (esperado ${WAIT_TIMEOUT}s)."
    exit 2
  fi
done
echo

# Helper para ejecutar un archivo sql dentro del contenedor y guardar log
run_sql_file() {
  local src_file="$1"
  local base
  base="$(basename "$src_file")"
  local remote="/tmp/$base"
  local logfile="$LOG_DIR/$base.log"

  echo "==> Ejecutando $base ..."
  # Copiar archivo al contenedor
  docker cp "$src_file" "$SQL_CONTAINER_NAME":"$remote"

  # Ejecutar con sqlcmd dentro del contenedor; volcar stdout/stderr al log
  docker exec --user root "$SQL_CONTAINER_NAME" /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -i "$remote" -b > "$logfile" 2>&1
  local rc=$?

  # Limpiar archivo dentro del contenedor
  docker exec --user root "$SQL_CONTAINER_NAME" rm -f "$remote" >/dev/null 2>&1 || true

  if [ $rc -ne 0 ]; then
    echo "ERROR ejecutando $base (rc=$rc). Revisa el log: $logfile"
    echo "Últimas 80 líneas del log:"
    tail -n 80 "$logfile" || true
    return $rc
  else
    echo "OK: $base (log: $logfile)"
  fi
  return 0
}

# 3) Ejecutar Tablas (orden natural)
TAB_DIR="$PROJECT_DIR/Tablas"
if [ -d "$TAB_DIR" ]; then
  echo "Ejecutando scripts en $TAB_DIR ..."
  mapfile -t tab_files < <(ls -1v "$TAB_DIR"/*.sql 2>/dev/null || true)
  if [ "${#tab_files[@]}" -eq 0 ]; then
    echo "No se encontraron archivos .sql en $TAB_DIR"
  else
    for f in "${tab_files[@]}"; do
      run_sql_file "$f" || { echo "Abortando por error en $f"; exit 3; }
    done
  fi
else
  echo "Carpeta Tablas no existe: $TAB_DIR"
fi

# 4) Ejecutar Procedures (orden natural)
PROC_DIR="$PROJECT_DIR/Procedures"
if [ -d "$PROC_DIR" ]; then
  echo "Ejecutando scripts en $PROC_DIR ..."
  mapfile -t proc_files < <(ls -1v "$PROC_DIR"/*.sql 2>/dev/null || true)
  if [ "${#proc_files[@]}" -eq 0 ]; then
    echo "No se encontraron archivos .sql en $PROC_DIR"
  else
    for f in "${proc_files[@]}"; do
      run_sql_file "$f" || { echo "Abortando por error en $f"; exit 4; }
    done
  fi
else
  echo "Carpeta Procedures no existe: $PROC_DIR"
fi

echo "✅ Todos los scripts ejecutados correctamente."
exit 0
