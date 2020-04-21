#!/bin/bash
set -e
bash ./scripts/apply_openproject_sql_dump.sh {{ openproject.initFile }}
