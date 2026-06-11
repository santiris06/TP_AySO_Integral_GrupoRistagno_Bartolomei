#!/bin/bash

# ================================
# Script Creación de Usuarios
# Idempotente
# ================================

USUARIOS=("usuario1" "usuario2" "usuario3")
GRUPO="grupo_tp"

echo "==> Iniciando creación de usuarios..."

# Crear grupo si no existe
if ! getent group $GRUPO > /dev/null 2>&1; then
    groupadd $GRUPO
    echo "Grupo $GRUPO creado"
else
    echo "Grupo $GRUPO ya existe, saltando..."
fi

# Crear cada usuario
for USUARIO in "${USUARIOS[@]}"; do
    if ! id "$USUARIO" > /dev/null 2>&1; then
        useradd -m -g $GRUPO -s /bin/bash $USUARIO
        echo "$USUARIO:password123" | chpasswd
        echo "Usuario $USUARIO creado"
    else
        echo "Usuario $USUARIO ya existe, saltando..."
    fi
done

echo "==> Usuarios creados correctamente!"
