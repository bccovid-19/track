#!/bin/bash
set -e

cat << EOF | docker-compose exec -T -u postgres op-db psql openproject
UPDATE public.settings
SET value='{{ apps.openproject.hostname }}'
WHERE name='host_name';
EOF
