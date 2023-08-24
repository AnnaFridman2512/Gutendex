#!/bin/bash


source .env

# Wait for PostgreSQL to become available
while ! pg_isready -h $DATABASE_NAME -U $DATABASE_USER -p $DATABASE_PORT -q; do
    sleep 2
done

export PGPASSWORD=$DATABASE_PASSWORD
psql -h $DATABASE_NAME -U $DATABASE_USER -d $DATABASE_NAME -c "GRANT ALL PRIVILEGES ON DATABASE $DATABASE_NAME TO $DATABASE_USER;"

# Apply Django migrations
./manage.py migrate

# Populate the Database
./manage.py updatecatalog

# Collect static files
./manage.py collectstatic


./manage.py runserver 0.0.0.0:8000
