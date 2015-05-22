#!/bin/bash

# generate-config-file.sh
# Author: Michael Stealey <michael.j.stealey@gmail.com>

CONFIG_FILE=$1

echo "SERVICE_ACCT_USERNAME: irods" > $CONFIG_FILE
echo "SERVICE_ACCT_GROUP: irods" >> $CONFIG_FILE
echo "IRODS_ZONE: tempZone" >> $CONFIG_FILE
echo "IRODS_PORT: 1247" >> $CONFIG_FILE
echo "RANGE_BEGIN: 20000" >> $CONFIG_FILE
echo "RANGE_END: 20199" >> $CONFIG_FILE
echo "VAULT_DIRECTORY: /var/lib/irods/iRODS/Vault" >> $CONFIG_FILE
echo "ZONE_KEY: "$(pwgen -c -n -1 16) >> $CONFIG_FILE
echo "NEGOTIATION_KEY: "$(pwgen -c -n -1 32) >> $CONFIG_FILE
echo "CONTROL_PLANE_PORT: 1248" >> $CONFIG_FILE
echo "CONTROL_PLANE_KEY: "$(pwgen -c -n -1 32) >> $CONFIG_FILE
echo "SCHEMA_VALIDATION_BASE_URI: https://schemas.irods.org/configuration" >> $CONFIG_FILE
echo "ADMINISTRATOR_USERNAME: rods" >> $CONFIG_FILE
echo "ADMINISTRATOR_PASSWORD: "$(pwgen -c -n -1 16) >> $CONFIG_FILE
echo "HOSTNAME_OR_IP: db" >> $CONFIG_FILE
echo "DATABASE_PORT: 5432" >> $CONFIG_FILE
echo "DATABASE_NAME: ICAT" >> $CONFIG_FILE
echo "DATABASE_USER: irods" >> $CONFIG_FILE
echo "DATABASE_PASSWORD: "$(pwgen -c -n -1 16) >> $CONFIG_FILE

exit;