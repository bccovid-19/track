#!/bin/bash
set -e

COMPOSE_FILE=${1:-./docker-compose.yml}
TARGET=${1:-./backups}
mkdir -p $TARGET

OUTPUT_FILE=$TARGET/openproject-structure-$(date +'%Y%m%d-%H%M%S').sql
echo $'-- PostgreSQL SQL dump to import OpenProject structural tables, e.g. workflows and custom fields\n\n' > $OUTPUT_FILE

{%- for table in openproject.structureTables %}
echo $'DROP TABLE {{ table }};\n' >> $OUTPUT_FILE
{%- endfor %}

docker-compose -f $COMPOSE_FILE exec -T -u postgres op-db pg_dump -d openproject \
{%- for table in openproject.structureTables %}
  -t public.{{ table }} \
{%- endfor %}
  >> $OUTPUT_FILE
