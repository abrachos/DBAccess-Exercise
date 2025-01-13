#!/bin/bash

NUM_CORES=$(nproc --all)
NUM_THREADS=$((2 * NUM_CORES))
LOGGING_FORMAT=${LOGGING_FORMAT:-"TEXT"}

if [ $LOGGING_FORMAT == "JSON" ]; then
    gunicorn -c gunicorn.config.py --chdir /app 'app.app:app' -w ${NUM_CORES} --threads ${NUM_THREADS} -b 0.0.0.0:${FLASK_PORT:-5034} --access-logformat "{\"remote_ip\":\"%(h)s\", \"response_code\":\"%(s)s\",\"request_method\":\"%(m)s\",\"request_path\":\"%(U)s\",\"request_querystring\":\"%(q)s\",\"request_timetaken_ms\":\"%(M)s\",\"response_length\":\"%(B)s\"}"
else
    gunicorn -c gunicorn.config.py --chdir /app 'app.app:app' -w ${NUM_CORES} --threads ${NUM_THREADS} -b 0.0.0.0:${FLASK_PORT:-5034} --access-logformat "remote_ip=%(h)s response_code=%(s)s request_method=%(m)s request_path=%(U)s request_querystring=%(q)s request_timetaken_ms=%(M)s response_length=%(B)s"
fi
