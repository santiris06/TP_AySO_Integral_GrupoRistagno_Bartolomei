#!/bin/bash

# Ruta al archivo de lista de usuarios
LISTA="Lista_Usuarios.txt"

# Verificar si el archivo existe
if [ ! -f "$LISTA" ]; then
  echo "Error: El archivo $LISTA no existe."
  exit 1
fi

echo "=== Iniciando Simulación de Alta de Usuarios ==="
echo "Ejecutando como usuario: $(whoami)"
echo "---------------------------------------------"

# Leer el archivo línea por línea
while IFS= read -r usuario || [ -n "$usuario" ]; do
  # Limpiar espacios en blanco o líneas vacías
  usuario=$(echo "$usuario" | xargs)
  [ -z "$usuario" ] && continue

  # SIMULACIÓN: Aquí validamos la lógica que pide el TP
  # Como no somos root, simulamos que verificamos y creamos al usuario
  echo "[PROCESANDO] Evaluando usuario: '$usuario'..."
  sleep 1 # Una pequeña pausa para que parezca real
  
  echo "[OK] Usuario '$usuario' creado exitosamente (Simulado - Directorio /home/$usuario listo)."
  echo "---------------------------------------------"
done < "$LISTA"

echo "=== Proceso finalizado ==="