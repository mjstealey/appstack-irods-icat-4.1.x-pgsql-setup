#!/bin/bash

# setupdb.sh
# Sets up a Postgres database for iRODS by creating a database and user and granting
# privileges to the user.

RESPFILE=$1
IRODS_DB_ADMIN_USER=`tail -n 3 $RESPFILE | head -n 1`
IRODS_DB_ADMIN_PASS=`tail -n 2 $RESPFILE | head -n 1`
SECRETS_FILE='/root/.secret/secrets.yaml'

# Get secrets from postgresql install
sed -e "s/:[^:\/\/]/=/g;s/$//g;s/ *=/=/g" $SECRETS_FILE > /root/.secret/secrets.sh
while read line; do export $line; done < <(cat /root/.secret/secrets.sh)

# Create .pgpass file for user postgres
echo "*:*:*:*:${PGSETUP_POSTGRES_PASSWORD}" > /var/lib/pgsql/.pgpass
chmod 0600 /var/lib/pgsql/.pgpass
chown postgres:postgres /var/lib/pgsql/.pgpass

# Rename existing database to ICAT
sudo -u postgres psql -h db -c "ALTER DATABASE \"${PGSETUP_DATABASE_NAME}\" RENAME TO \"ICAT\""
# Create irods database user and grant all privileges to that user
sudo -u postgres psql -h db -c "CREATE USER ${IRODS_DB_ADMIN_USER} WITH PASSWORD '${IRODS_DB_ADMIN_PASS}'"
sudo -u postgres psql -h db -c "GRANT ALL PRIVILEGES ON DATABASE \"ICAT\" TO ${IRODS_DB_ADMIN_USER}"

# Update secrets file with new information
sed -i "s/${PGSETUP_DATABASE_NAME}/ICAT/g" $SECRETS_FILE

cat << EOF >> $SECRETS_FILE
IRODS_DB_ADMIN_USER: $IRODS_DB_ADMIN_USER
IRODS_DB_ADMIN_PASS: $IRODS_DB_ADMIN_PASS
EOF

# Refresh environment variables derived from updated secrets
sed -e "s/:[^:\/\/]/=/g;s/$//g;s/ *=/=/g" $SECRETS_FILE > /root/.secret/secrets.sh
while read line; do export $line; done < <(cat /root/.secret/secrets.sh)
