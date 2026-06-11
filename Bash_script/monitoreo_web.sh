#!/bin/bash

# ================================
# Script Monitoreo Web
# ================================

SITIOS=(
    "https://www.google.com"
    "https://www.github.com"
    "https://www.utn.edu.ar"
)

LOG="/var/log/monitoreo_web.log"
FECHA=$(date '+%Y-%m-%d %H:%M:%S')

echo "==> Iniciando monitoreo web... $FECHA"

for SITIO in "${SITIOS[@]}"; do
    # Intenta conectarse al sitio
    HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 $SITIO)

    if [ "$HTTP_CODE" -eq 200 ]; then
        ESTADO="✅ ONLINE"
    else
        ESTADO="❌ OFFLINE (código: $HTTP_CODE)"
    fi

    # Muestra en pantalla
    echo "$FECHA | $SITIO | $ESTADO"

    # Guarda en log
    echo "$FECHA | $SITIO | $ESTADO" >> $LOG
done

echo "==> Monitoreo finalizado. Log guardado en $LOG"
