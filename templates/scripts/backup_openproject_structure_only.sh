#!/bin/bash
set -e

COMPOSE_FILE=${1:-./docker-compose.yml}
TARGET=${1:-./backups}
mkdir -p $TARGET

OUTPUT_FILE=$TARGET/openproject-structure-$(date -Is).sql

{%- for table in openproject.structureTables %}
echo "DROP TABLE {{ table }}\n" > $OUTPUT_FILE
{%- endfor %}

docker-compose exec -f $COMPOSE_FILE -T -u postgres op-db pg_dump -d openproject \
{%- for table in openproject.structureTables %}
  -t {{ table }} \
{%- endfor %}
  > $OUTPUT_FILE
