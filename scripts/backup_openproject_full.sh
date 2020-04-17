#!/usr/bin/env bash
set -e

COMPOSE_FILE=${1:-./docker-compose.yml}
TARGET=${1:-./backups}

mkdir -p $TARGET

docker-compose exec -f $COMPOSE_FILE -T -u postgres op-db pg_dump -d openproject | gzip > $TARGET/openproject-$(date -Is).sql.gz
