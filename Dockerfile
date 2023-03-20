FROM codercom/code-server:latest
USER root
# Establece la contraseña de acceso al servidor web
ENV PASSWORD=

RUN sudo apt-get update && sudo apt-get install -y supervisor
# Instala las extensiones de VS Code
RUN code-server --install-extension esbenp.prettier-vscode && \
    code-server --install-extension ms-python.python

## INSTALA TODO LOS PROGRAMAS NECESARIOS PARA EJECUTAR WHISPER
RUN apt-get install -y python3 python3-pip git ffmpeg
RUN pip install -U openai-whisper
RUN pip install git+https://github.com/openai/whisper.git
RUN pip install setuptools-rust
RUN pip install --upgrade --no-deps --force-reinstall git+https://github.com/openai/whisper.git

# Configuración de Supervisor
RUN sudo echo '[program:code-server]\n\
command=/usr/bin/code-server --bind-addr 0.0.0.0:8080 --auth password $PASSWORD --user-data-dir /root .\n\
user=root\n\
autostart=true\n\
autorestart=true\n\
stderr_logfile=/var/log/code-server.err.log\n\
stdout_logfile=/var/log/code-server.out.log' >> /etc/supervisor/conf.d/vscode.conf

# Expone el puerto utilizado por el servidor web
EXPOSE 8080
WORKDIR /root
## COPIA EL MENÚ BÁSICO DE WHISPER
COPY menu /usr/sbin/menu
## ASIGNA PERMISOS DE EJECUCIÓN
RUN chmod 777 /usr/sbin/menu
# Inicia Supervisor y el servidor web
CMD ["/usr/bin/supervisord"]
