import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    #Database URL
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL', '')


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
