#!/bin/bash
set -e

if [ -z "$1" ]
  then
    echo "Please give a .sql file as an argument"
fi

echo 'Shutting down all containers to apply patch'
docker-compose down
docker-compose up -d op-db
cat $1 | docker-compose exec -T -u postgres op-db psql openproject
docker-compose down
echo 'Patch applied, restart containers with docker-compose up -d'