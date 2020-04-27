#!/usr/bin/env bash
set -e

# Template our config files
docker-compose -f ./apps/templating/docker-compose.yml build
docker-compose -f ./apps/templating/docker-compose.yml run templating

# Build the website
docker-compose -f ./apps/bcc3d.ca/build.docker-compose.yml build
docker-compose -f ./apps/bcc3d.ca/build.docker-compose.yml run jekyll-build

# Build any images required for the stack
docker-compose -f ./docker-compose.yml build
