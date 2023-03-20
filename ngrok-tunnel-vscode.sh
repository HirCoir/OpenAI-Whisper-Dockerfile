#!/bin/bash

# Verificar si curl está instalado
if ! command -v curl &> /dev/null
then
    # Instalar curl si no está instalado
    echo "curl no está instalado. Instalando..."
    sudo apt update
    sudo apt install curl -y
fi

# Verificar si wget está instalado
if ! command -v wget &> /dev/null
then
    # Instalar wget si no está instalado
    echo "wget no está instalado. Instalando..."
    sudo apt update
    sudo apt install wget -y
fi

# Verificar si unzip está instalado
if ! command -v unzip &> /dev/null
then
    # Instalar unzip si no está instalado
    echo "unzip no está instalado. Instalando..."
    sudo apt update
    sudo apt install unzip -y
fi

# Verificar si jq está instalado
if ! command -v jq &> /dev/null
then
    # Instalar jq si no está instalado
    echo "jq no está instalado. Instalando..."
    sudo apt update
    sudo apt install jq -y
fi

# Verificar si ngrok está instalado
if ! command -v ngrok &> /dev/null
then
    # Eliminar archivo zip y binario de ngrok si ya existen
    if [ -f ngrok-stable-linux-amd64.zip ]; then
        rm ngrok-stable-linux-amd64.zip
    fi
    if [ -f ngrok ]; then
        rm ngrok
    fi
    
    # Descargar ngrok si no está instalado
    echo "ngrok no está instalado. Descargando..."
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    unzip ngrok-stable-linux-amd64.zip
    mv ngrok /usr/sbin/ngrok
    chmod 777 /usr/sbin/ngrok
    rm ngrok-stable-linux-amd64.zip
fi

# Pedir token de autenticación
read -p "Ingrese su token de autenticación de ngrok: " token
echo "Iniciando servidor tcp en el puerto 8080..."
# Iniciar servidor tcp en el puerto 8080
ngrok tcp 8080 --authtoken $token > /dev/null &

# Esperar un segundo para asegurarse de que ngrok esté en ejecución
sleep 1

# Obtener la url generada por ngrok
url=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url' | sed 's/tcp:\/\///')

# Mostrar la url en la terminal
echo "Tu servidor está disponible en $url"
