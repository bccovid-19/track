# track.bcc3d.ca app stack

Starting the web-app (can be done locally, hopefully):

1. Copy the settings in `example-config.yml` into `config.yml`.
1. Run `./build.sh` to build the templates into the local directory.
1. Run `docker-compose up -d` to bring the docker-compose stack up.
1. Run `./scripts/init_db` to import a workflow
1. Visit `www.local.bcc3d.ca` to see your local application!

If you want to view logs use `docker-compose logs --tail=100 -f`

## SSL termination

Starting the SSL layer:

1. `cd apps/ssl`
1. `docker-compose up -d`
