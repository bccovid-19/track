# track.bcc3d.ca app stack

Starting the web-app (can be done locally, hopefully):

1. Edit the settings in `config.yml` 
2. Run `sh build.sh` to build the templates into `./build`
3. Run `sh start.sh` to bring the docker-compose stack up.

If you want to view logs use `docker-compose -f build/docker-compose.yml logs --tail=100 -f`

## SSL termination

Starting the SSL layer:

1. `cd apps/ssl`
2. `docker-compose up -d`
