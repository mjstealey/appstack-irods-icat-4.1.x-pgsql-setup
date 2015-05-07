#!/bin/bash

# bootstrap.sh
# Author: Michael Stealey <michael.j.stealey@gmail.com>

# generate configuration responses
/scripts/generate-irods-response.sh /scripts/setup_responses

# set up the iCAT database
/scripts/setup-irods-db-admin.sh /scripts/setup_responses

# set up iRODS
/scripts/configure-irods.sh /scripts/setup_responses

#change irods user's irods_environment.json file to point to localhost, since it was configured with a transient Docker container's $
sed -i 's/"irods_host".*/"irods_host": "localhost",/g' /var/lib/irods/.irods/irods_environment.json
