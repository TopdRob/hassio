#!/usr/bin/env bash

# ANSI color codes
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}Updating environment${NC}"

# Configure Spoolman to listen on the Ingress host and port
export SPOOLMAN_HOST=$(bashio::addon.ingress_host)
export SPOOLMAN_PORT=$(bashio::addon.ingress_port)
export SPOOLMAN_BASE_PATH=$(bashio::addon.ingress_entry)

# Set other Spoolman environment variables
export SPOOLMAN_DB_TYPE=sqlite
export SPOOLMAN_DIR_DATA=/config/spoolman
export SPOOLMAN_DIR_BACKUPS=/config/spoolman/backups
export SPOOLMAN_DIR_LOGS=/config/spoolman

# User-configurable options
SPOOLMAN_DEBUG_MODE=$(bashio::config 'debug_mode')
export SPOOLMAN_DEBUG_MODE
SPOOLMAN_LOGGING_LEVEL=$(bashio::config 'log_level')
export SPOOLMAN_LOGGING_LEVEL
SPOOLMAN_AUTOMATIC_BACKUP=$(bashio::config 'auto_backup')
export SPOOLMAN_AUTOMATIC_BACKUP

# Start the Spoolman application directly
# Dit roept het originele start.sh script van Spoolman aan in de uitgepakte map
echo -e "${ORANGE}Starting Spoolman using original start script...${NC}"
cd /var/spoolman
./scripts/start.sh
