#!/usr/bin/env bash
set -e

let filename = openproject-structure-$(date -Is).sql

echo DROP TABLE

docker-compose exec -T -u postgres op-db pg_dump -d openproject \
  -t  \
  -t  \
  | gzip > ./backups/.sql.gz
