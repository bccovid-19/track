#!/bin/bash
set -e

TARGET=${1:-./backups}
mkdir -p $TARGET
TARGET_FILE=$TARGET/openproject-$(date +'%Y%m%d-%H%M%S').sql

echo -e 'DROP DATABASE openproject;\n' > $TARGET_FILE
docker-compose exec -T -u postgres op-db pg_dump -d openproject >> $TARGET_FILE
