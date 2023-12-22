########################################################################
#   Logger Module
#   Usage:
#       from core import logger
#       logger.info("This is a info message")
########################################################################

from os import environ as env
import logging

LEVEL = env.get("DEBUG_LEVEL", "DEBUG").upper()
NICKNAME = env.get("NICKNAME").upper()

FORMAT = "%(asctime)s %(clientip)-15s %(user)-8s %(message)s"

logging.basicConfig(level=LEVEL, format=FORMAT)

logger = logging.getLogger(name=NICKNAME)
