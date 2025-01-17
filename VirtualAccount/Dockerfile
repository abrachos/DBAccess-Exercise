# Usa una imagen base de Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo requirements.txt y luego instálalo
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y postgresql-client

# Copia el contenido del directorio actual al contenedor
COPY . .

# Establece la variable de entorno
ENV APP_SETTINGS=config.DevelopmentConfig

# Expone el puerto que la aplicación usará
EXPOSE 5034

# Ejecuta la aplicación Flask directamente
CMD ["python", "app.py"]
