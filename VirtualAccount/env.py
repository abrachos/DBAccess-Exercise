import os

LOGGING_LEVEL = os.environ.get("LOGGIN_LEVEL", "ERROR")
LOGGING_FORMAT = os.environ.get("LOGGING_FORMAT", "TEXT")
FLASK_HOST_ADDRESS = os.environ.get("FLASK_HOST_ADDRESS", "127.0.0.1")
FLASK_PORT = int(os.environ.get("FLASK_PORT", 5034))
FLASK_DEBUG = os.environ.get("FLASK_DEBUG", "True").lower() == "true"
APP_SETTINGS = os.environ.get("APP_SETTINGS", "config.DevelopmentConfig") 
DATABASE_URL = os.environ.get("DATABASE_URL", "postgresql://<usuario>:<contraseña>@<host>:<puerto>/<nombre_base_de_datos>")