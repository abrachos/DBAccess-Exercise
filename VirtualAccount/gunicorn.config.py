import json

import structlog

from app.env import LOGGING_FORMAT

timestamper = structlog.processors.TimeStamper(fmt="%Y-%m-%d %H:%M:%S")
pre_chain = [
    # Add the log level and a timestamp to the event_dict if the log entry
    # is not from structlog.
    structlog.stdlib.add_log_level,
    structlog.stdlib.add_logger_name,
    timestamper,
]


def handle_flask_logs(event_dict, **kw):
    mod = {}
    if "event" in event_dict:
        try:
            # This event is from Flask, and hence it is a valid JSON string
            # Convert is back to dictionary to avoid double json serialization
            mod = mod | json.loads(event_dict["event"])
        except ValueError:
            mod["event"] = event_dict["event"]
    for k in event_dict:
        if k != "event":
            mod[k] = event_dict[k]
    return json.dumps(mod, **kw)


logconfig_dict = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "json_formatter": {
            "()": structlog.stdlib.ProcessorFormatter,
            "processor": structlog.dev.ConsoleRenderer()
            if LOGGING_FORMAT == "TEXT"
            else structlog.processors.JSONRenderer(serializer=handle_flask_logs),
            "foreign_pre_chain": pre_chain,
        }
    },
    "handlers": {
        "error_console": {
            "class": "logging.StreamHandler",
            "formatter": "json_formatter",
        },
        "console": {
            "class": "logging.StreamHandler",
            "formatter": "json_formatter",
        },
    },
}