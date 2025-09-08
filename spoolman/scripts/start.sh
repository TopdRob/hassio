#!/bin/bashio

# ANSI color codes
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}Updating environment${NC}"

# Configure Spoolman to listen on the Ingress host and port
# The Supervisor provides these values via environment variables.
export SPOOLMAN_HOST=$(bashio::addon.ingress_host)
export SPOOLMAN_PORT=$(bashio::addon.ingress_port)
export SPOOLMAN_BASE_PATH=$(bashio::addon.ingress_entry)

# Set other Spoolman environment variables
export SPOOLMAN_DB_TYPE=sqlite
export SPOOLMAN_DIR_DATA=/config
export SPOOLMAN_DIR_BACKUPS=/config/backups
export SPOOLMAN_DIR_LOGS=/config

# User-configurable options
SPOOLMAN_DEBUG_MODE=$(bashio::config 'debug_mode')
export SPOOLMAN_DEBUG_MODE
SPOOLMAN_LOGGING_LEVEL=$(bashio::config 'log_level')
export SPOOLMAN_LOGGING_LEVEL
SPOOLMAN_AUTOMATIC_BACKUP=$(bashio::config 'auto_backup')
export SPOOLMAN_AUTOMATIC_BACKUP

# Start the Spoolman application
/var/spoolman/scripts/start.sh
