#!/bin/bash
set -e

COMPOSE_FILE=${1:-./docker-compose.yml}
TARGET=${1:-./backups}
mkdir -p $TARGET

OUTPUT_FILE=$TARGET/openproject-structure-$(date +'%Y%m%d-%H%M%S').sql
echo '-- PostgreSQL SQL dump to import OpenProject structural tables, e.g. workflows and custom fields' > $OUTPUT_FILE
echo "DROP TABLE custom_actions;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_actions_projects;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_actions_roles;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_actions_statuses;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_actions_types;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_fields;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_fields_projects;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_fields_types;\n" >> $OUTPUT_FILE
echo "DROP TABLE custom_options;\n" >> $OUTPUT_FILE

docker-compose -f $COMPOSE_FILE exec -T -u postgres op-db pg_dump -d openproject \
  -t public.custom_actions \
  -t public.custom_actions_projects \
  -t public.custom_actions_roles \
  -t public.custom_actions_statuses \
  -t public.custom_actions_types \
  -t public.custom_fields \
  -t public.custom_fields_projects \
  -t public.custom_fields_types \
  -t public.custom_options \
  >> $OUTPUT_FILE