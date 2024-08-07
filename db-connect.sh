#!/bin/bash

# Function to set env var if not already set
set_env_var() {
    local var_name=$1
    local var_value=$2

    if [ -z "${!var_name}" ]; then
        gp env "$var_name=$var_value" > /dev/null 2>&1
        echo "$var_name set."
    else
        echo "$var_name already set, skipping."
    fi
}

# Set static environment variables using gp env
set_env_var PGUSER "dbadmin"
set_env_var PGHOST "postgres-auroraserverlesscluster-t8j6zclo0ggk.cluster-cjwsanmihnmb.eu-central-1.rds.amazonaws.com"
set_env_var PGPORT "3306"

# Set password if not already set
if [ -z "$PGPASSWORD" ]; then
    read -sp "Enter PostgreSQL password: " DB_PASSWORD
    echo
    gp env PGPASSWORD="$DB_PASSWORD" > /dev/null 2>&1
    echo "PGPASSWORD set."
else
    echo "PGPASSWORD already set, skipping."
fi

# Calculate and set DB name if not already set
if [ -z "$PGDATABASE" ]; then
    if [ -z "$GITPOD_GIT_USER_EMAIL" ]; then
        echo "Error: GITPOD_GIT_USER_EMAIL is not set."
        exit 1
    fi
    DB_NAME=$(echo "$GITPOD_GIT_USER_EMAIL" | cut -d '@' -f 1)
    gp env PGDATABASE="$DB_NAME"
    echo "PGDATABASE set to $DB_NAME."
else
    echo "PGDATABASE already set, skipping."
fi

# Export the variables for the current session
eval $(gp env -e)

# Check if the database exists, if not create it
if ! psql -lqt | cut -d \| -f 1 | grep -qw "$PGDATABASE"; then
    echo "Database $PGDATABASE does not exist. Creating..."
    if createdb "$PGDATABASE"; then
        echo "Database $PGDATABASE created successfully."
    else
        echo "Error: Failed to create database $PGDATABASE."
        exit 1
    fi
else
    echo "Database $PGDATABASE already exists."
fi

echo "Current environment variables:"
echo "PGUSER=$PGUSER"
echo "PGPASSWORD=********"
echo "PGHOST=$PGHOST"
echo "PGPORT=$PGPORT"
echo "PGDATABASE=$PGDATABASE"