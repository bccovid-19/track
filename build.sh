#!/usr/bin/env bash
set -e

docker-compose -f apps/templating/docker-compose.yml build
docker-compose -f apps/templating/docker-compose.yml up
docker-compose -f build/docker-compose.yml build
