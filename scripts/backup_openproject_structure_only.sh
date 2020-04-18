#!/bin/bash
set -e

COMPOSE_FILE=${1:-./docker-compose.yml}
TARGET=${1:-./backups}
mkdir -p $TARGET

OUTPUT_FILE=$TARGET/openproject-structure-$(date -Is).sql
echo "DROP TABLE custom_actions\n" > $OUTPUT_FILE
echo "DROP TABLE custom_actions_projects\n" > $OUTPUT_FILE
echo "DROP TABLE custom_actions_roles\n" > $OUTPUT_FILE
echo "DROP TABLE custom_actions_statuses\n" > $OUTPUT_FILE
echo "DROP TABLE custom_actions_types\n" > $OUTPUT_FILE
echo "DROP TABLE custom_fields\n" > $OUTPUT_FILE
echo "DROP TABLE custom_fields_projects\n" > $OUTPUT_FILE
echo "DROP TABLE custom_fields_types\n" > $OUTPUT_FILE
echo "DROP TABLE custom_options\n" > $OUTPUT_FILE

docker-compose exec -f $COMPOSE_FILE -T -u postgres op-db pg_dump -d openproject \
  -t custom_actions \
  -t custom_actions_projects \
  -t custom_actions_roles \
  -t custom_actions_statuses \
  -t custom_actions_types \
  -t custom_fields \
  -t custom_fields_projects \
  -t custom_fields_types \
  -t custom_options \
  > $OUTPUT_FILE