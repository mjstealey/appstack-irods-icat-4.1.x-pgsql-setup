#!/bin/bash

# configure-irods.sh
# Author: Michael J. Stealey <michael.j.stealey@gmail.com>

RESPFILE=$1

# Install iRODS RPMs - uncomment packages as required
cd /files/
# Install irods-icat
rpm -i $(ls -l | tr -s ' ' | grep irods-icat | cut -d ' ' -f 9)
# Install irods-database-plugin
rpm -i $(ls -l | tr -s ' ' | grep irods-database-plugin | cut -d ' ' -f 9)
# Install irods-dev
#rpm -i $(ls -l | tr -s ' ' | grep irods-dev | cut -d ' ' -f 9)
# Install irods-runtime
#rpm -i $(ls -l | tr -s ' ' | grep irods-runtime | cut -d ' ' -f 9)
# Install irods-microservice-plugins
#rpm -i $(ls -l | tr -s ' ' | grep irods-microservice-plugins | cut -d ' ' -f 9)

# Run the iRODS setup script
/var/lib/irods/packaging/setup_irods.sh < $1

# Save copy of /usr/bin/genOSAuth
cp /usr/bin/genOSAuth /root/.secret/genOSAuth