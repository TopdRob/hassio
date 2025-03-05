#!/bin/bashio

# ANSI color codes
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}Updating .env${NC}"

base_path=""
if bashio::config.has_value 'base_path' ;then
    base_path=$(bashio::config 'base_path')
fi
env="SPOOLMAN_DB_TYPE=sqlite
SPOOLMAN_LOGGING_LEVEL=$(bashio::config 'log_level')
SPOOLMAN_AUTOMATIC_BACKUP=$(bashio::config 'auto_backup')
SPOOLMAN_DIR_DATA=/config
SPOOLMAN_DIR_BACKUPS=/config/backups
SPOOLMAN_DIR_LOGS=/config
SPOOLMAN_HOST=0.0.0.0
SPOOLMAN_PORT=7912
SPOOLMAN_BASE_PATH=${base_path}
SPOOLMAN_DEBUG_MODE=$(bashio::config 'debug_mode')"
echo "$env" | tee /var/spoolman/.env

/var/spoolman/scripts/start.sh