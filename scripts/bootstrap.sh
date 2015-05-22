#!/bin/bash

# bootstrap.sh
# Author: Michael Stealey <michael.j.stealey@gmail.com>

##############################
### IRODS CONFIG VARIABLES ###
##############################

IRODS_CONFIG_FILE='irods-config.yaml'
IRODS_SETUP_FILE='setup_responses'

### CREATE CONFIG FILE ###

if [[ -e /conf/$IRODS_CONFIG_FILE ]] ; then
    echo "*** Importing existing configuration file: /conf/${IRODS_CONFIG_FILE} ***"
    cp /conf/${IRODS_CONFIG_FILE} /files;
else
    echo "*** Generating configuration file: /files/${IRODS_CONFIG_FILE} ***"
    /scripts/generate-config-file.sh /files/${IRODS_CONFIG_FILE}
    cp /files/${IRODS_CONFIG_FILE} /conf;
fi

# generate configuration responses
/scripts/generate-irods-response.sh /files/$IRODS_SETUP_FILE

# set up the iCAT database
/scripts/setup-irods-db-admin.sh /files/$IRODS_SETUP_FILE

# set up iRODS
/scripts/configure-irods.sh /files/$IRODS_SETUP_FILE

# change irods user's irods_environment.json file to point to localhost, since it was configured with a transient Docker container
sed -i 's/"irods_host".*/"irods_host": "localhost",/g' /var/lib/irods/.irods/irods_environment.json

exit;