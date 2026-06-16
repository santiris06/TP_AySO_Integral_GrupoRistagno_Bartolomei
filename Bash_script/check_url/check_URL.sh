#!/bin/bash

# Ruta al archivo de URLs y al archivo de reporte
LISTA="Lista_URL.txt"
LOG_REPORTE="reporte_status.log"

# Verificar si el archivo de URLs existe
if [ ! -f "$LISTA" ]; then
  echo "Error: El archivo $LISTA no existe."
  exit 1
fi

echo "=== Iniciando Chequeo de URLs ($(date '+%Y-%m-%d %H:%M:%S')) ===" | tee -a "$LOG_REPORTE"
echo "Ejecutando como usuario: $(whoami)"
echo "--------------------------------------------------------" | tee -a "$LOG_REPORTE"

# Leer el archivo línea por línea
while IFS= read -r url || [ -n "$url" ]; do
  # Limpiar espacios en blanco o líneas vacías
  url=$(echo "$url" | xargs)
  [ -z "$url" ] && continue

  # Realizar la consulta HTTP usando curl
  # --write-out '%{http_code}' devuelve solo el código numérico (ej. 200)
  # --silent --output /dev/null evita que se descargue o muestre el HTML
  # --connect-timeout 5 evita que el script se cuelgue si la web no responde
  status_code=$(curl --write-out '%{http_code}' --silent --output /dev/null --connect-timeout 5 "$url")

  if [ "$status_code" -eq 200 ]; then
    echo "[ONLINE] [Código $status_code] -> $url" | tee -a "$LOG_REPORTE"
  elif [ "$status_code" -eq 301 ] || [ "$status_code" -eq 302 ]; then
    echo "[REDIRECCIÓN] [Código $status_code] -> $url" | tee -a "$LOG_REPORTE"
  elif [ "$status_code" -eq 000 ]; then
    echo "[OFFLINE] [Inalcanzable/Time-out] -> $url" | tee -a "$LOG_REPORTE"
  else
    echo "[ALERTA] [Código $status_code] -> $url" | tee -a "$LOG_REPORTE"
  fi

done < "$LISTA"

echo "--------------------------------------------------------" | tee -a "$LOG_REPORTE"
echo "=== Fin del chequeo ===" | tee -a "$LOG_REPORTE"
echo "Resultados guardados en: $LOG_REPORTE"