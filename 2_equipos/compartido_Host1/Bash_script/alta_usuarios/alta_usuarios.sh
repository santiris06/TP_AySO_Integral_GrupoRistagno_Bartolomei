#!/bin/bash


LISTA="Lista_Usuarios.txt"

if [ ! -f "$LISTA" ]; then
  echo "Error: El archivo $LISTA no existe."
  exit 1
fi

echo "=== Iniciando Simulación de Alta de Usuarios ==="
echo "Ejecutando como usuario: $(whoami)"
echo "---------------------------------------------"

while IFS= read -r usuario || [ -n "$usuario" ]; do

  usuario=$(echo "$usuario" | xargs)
  [ -z "$usuario" ] && continue

  echo "[PROCESANDO] Evaluando usuario: '$usuario'..."
  sleep 1 
  
  echo "[OK] Usuario '$usuario' creado exitosamente (Simulado - Directorio /home/$usuario listo)."
  echo "---------------------------------------------"
done < "$LISTA"

echo "=== Proceso finalizado ==="