# track.bcc3d.ca app stack

Starting the web-app (can be done locally, hopefully):

1. Copy the settings in `example-config.yml` into `config.yml`, and edit as required.
2. Run `sh build.sh` to build the templates into the local directory.
3. Run `docker-compose up -d` to bring the docker-compose stack up.

If you want to view logs use `docker-compose logs --tail=100 -f`

## SSL termination

Starting the SSL layer:

1. `cd apps/ssl`
2. `docker-compose up -d`
