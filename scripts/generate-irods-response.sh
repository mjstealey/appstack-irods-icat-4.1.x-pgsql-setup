#!/bin/bash

# generate-irods-response.sh
# Author: Michael J. Stealey <michael.j.stealey@gmail.com>

################################
### CONFIGURE iRODS SETTINGS ###
################################

SERVICE_ACCT_USERNAME='irods'
SERVICE_ACCT_GROUP='irods'
IRODS_ZONE='tempZone'
IRODS_PORT='1247'
RANGE_BEGIN='20000'
RANGE_END='20199'
VAULT_DIRECTORY='/var/lib/irods/iRODS/Vault'
# LOCAL_ZONE_SID='TEMP_LOCAL_ZONE_SID'
# (openssl rand -base64 16 | sed 's,/,S,g' | cut -c 1-16 | tr -d '\n' ; echo "-SID")
# AGENT_KEY='temp_32_byte_key_for_agent__conn'
# openssl rand -base64 32 | sed 's,/,S,g' | cut -c 1-32
###
ZONE_KEY='TEMPORARY_zone_key'
# (openssl rand -base64 16 | sed 's,/,S,g' | cut -c 1-16 | tr -d '\n' ; echo "-SID")
NEGOTIATION_KEY='TEMPORARY_32byte_negotiation_key'
# openssl rand -base64 32 | sed 's,/,S,g' | cut -c 1-32
CONTROL_PLANE_PORT='1248'
CONTROL_PLANE_KEY='TEMPORARY__32byte_ctrl_plane_key'
SCHEMA_VALIDATION_BASE_URI='https://schemas.irods.org/configuration'
###
ADMINISTRATOR_USERNAME='rods'
ADMINISTRATOR_PASSWORD='rods'
# openssl rand -base64 16 | sed 's,/,S,g' | cut -c 1-16
HOSTNAME_OR_IP='db'
DATABASE_PORT='5432'
DATABASE_NAME='ICAT'
DATABASE_USER='irods'
DATABASE_PASSWORD='irods'
# openssl rand -base64 16 | sed 's,/,S,g' | cut -c 1-16

#######################
### iRODS RPM FILES ###
#######################

RESPFILE=$1

echo ${SERVICE_ACCT_USERNAME} > $RESPFILE       # service account user ID
echo ${SERVICE_ACCT_GROUP} >> $RESPFILE         # service account group ID
echo ${IRODS_ZONE} >> $RESPFILE                 # initial zone name
echo ${IRODS_PORT} >> $RESPFILE                 # service port #
echo ${RANGE_BEGIN} >> $RESPFILE                # transport starting port #
echo ${RANGE_END} >> $RESPFILE                  # transport ending port #
echo ${VAULT_DIRECTORY} >> $RESPFILE            # vault path
#echo ${LOCAL_ZONE_SID} >> $RESPFILE             # zone SID
#echo ${AGENT_KEY} >> $RESPFILE                  # agent key
echo ${ZONE_KEY} >> $RESPFILE                   # zone key
echo ${NEGOTIATION_KEY} >> $RESPFILE            # negotiation key
echo ${CONTROL_PLANE_PORT} >> $RESPFILE         # control plane port
echo ${CONTROL_PLANE_KEY} >> $RESPFILE          # control plane key
echo ${SCHEMA_VALIDATION_BASE_URI} >> $RESPFILE # schema validation base URI
echo ${ADMINISTRATOR_USERNAME} >> $RESPFILE     # iRODS admin account
echo ${ADMINISTRATOR_PASSWORD} >> $RESPFILE     # iRODS admin password
echo "yes" >> $RESPFILE                         # confirm iRODS settings
echo ${HOSTNAME_OR_IP} >> $RESPFILE             # database hostname
echo ${DATABASE_PORT} >> $RESPFILE              # database port
echo ${DATABASE_NAME} >> $RESPFILE              # database DB name
echo ${DATABASE_USER} >> $RESPFILE              # database admin username
echo ${DATABASE_PASSWORD} >> $RESPFILE          # database admin password
echo "yes" >> $RESPFILE                         # confirm database settings