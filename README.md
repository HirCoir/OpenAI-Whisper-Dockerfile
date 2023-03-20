## Whisper - Transcritor y traductor de audios
Este es un Dockerfile de Whisper que usa una imagen de VSCode para poder ser ejecutado con una interfáz web.

![](https://github.com/HirCoir/OpenAI-Whisper-Dockerfile/raw/main/images/whisper2.PNG)
![](https://github.com/HirCoir/OpenAI-Whisper-Dockerfile/raw/main/images/whisper3.PNG)
**Transcripción**
![](https://github.com/HirCoir/OpenAI-Whisper-Dockerfile/raw/main/images/whisper4.PNG)
**Traducción**
![enter image description here](https://github.com/HirCoir/OpenAI-Whisper-Dockerfile/raw/main/images/whisper5.PNG)

Para desplegarlo necesitas tener Docker y git instalado.
1. Clona este repositorio: `git clone https://github.com/HirCoir/OpenAI-Whisper-Dockerfile/`
2. Accede a la carpeta y crea la imagen: `cd OpenAI-Whisper-Dockerfile; docker build -t whisper-vscode .`
3. Ejecuta el contenedor, (en Pass123 reemplázalo por una contraseña diferente ya que es la que usarás para acceder a vscode-web): `docker run -d --name=whisper-vscode --restart=always -e PASSWORD=Pass123 -p 8080:8080 whisper-vscode`
4. Acceda a su ip:8080 y ponga la contraseña que definió en "-e PASSWORD=XXXX"

## Usar Whisper desde una imagen ya existente en dockerhub:
**AMD64/x86_x64**

`docker run -d --name=whisper-vscode --restart=always -e PASSWORD=Pass123 -p 8080:8080 hircoir/whisper-vscode:amd64`

**ARM64**

`docker run -d --name=whisper-vscode --restart=always -e PASSWORD=Pass123 -p 8080:8080 hircoir/whisper-vscode:arm64`

## Usar Whisper en Google Cloud Shell (Es gratis):
**Desplegar usando:**

`docker run -d --name=whisper-vscode --restart=always -e PASSWORD=Pass123 -p 8080:8080 hircoir/whisper-vscode:amd64`


**Al desplegarlo necesitas tener una cuenta de Ngrok para poder obtener un token y crear un tunel para poder acceder a la versión web:**


[Crear cuenta de Ngrok](https://dashboard.ngrok.com/get-started/setup)

`wget https://raw.githubusercontent.com/HirCoir/OpenAI-Whisper-Dockerfile/main/ngrok-tunnel; chmod 777 ngrok-tunnel; bash ngrok-tunnel`

Para usar Whisper solo abra la carpeta ROOT en VSCODE-WEB y arrastre directamente su archivo, abra un terminal y escriba el comando "menu" para mostrar las opciones... Tenga en cuenta que es un menú básico, recomiendo leer la [Documentación de Whisper.](https://github.com/openai/whisper)
![](https://github.com/HirCoir/OpenAI-Whisper-Dockerfile/raw/main/images/whisper1.PNG)
