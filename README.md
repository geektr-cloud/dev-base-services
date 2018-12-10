# dev-server

this project deployed via [geektr-cloud/deployer](https://github.com/geektr-cloud/deployer)

## Deploy

```bash
# update (init) project to local enviroment
# when first run, it will init data directory and secrets directory
deployer update geektr-cloud/dev-server

# edit secrets files
# vim xxxxxx

# up the services
deployer up geektr-cloud/dev-server
```

## Other Operation

reload caddy

```bash
# reload web server
./caddy-reload.sh
```

### npm usage

```bash
# directly pull pkgs
npm install @geektr.cloud/example --registry=https://npm.geektr.cloud
npm install @private.geektr.cloud/example --registry=https://npm.geektr.cloud

# normal usage
npm set @geektr.cloud:registry https://npm.geektr.cloud
npm set @private.geektr.cloud:registry https://npm.geektr.cloud
npm adduser --registry https://npm.geektr.cloud
npm publish --registry https://npm.geektr.cloud

# ci enviroment
tee -a $(npm config get userconfig) <<EOF
@geektr.cloud:registry=https://npm.geektr.cloud
@private.geektr.cloud:registry=https://npm.geektr.cloud
//npm.geektr.cloud/:_authToken="$GNPM_AUTH_TOKEN"
EOF

# write alias in .bashrc / .zshrc
alias gnpm="npm --registry=https://npm.geektr.cloud \
  --cache=$HOME/.npm/.cache/gnpm \
  --userconfig=$HOME/.gnpmrc"

alias garn="yarn --registry=https://npm.geektr.cloud \
  --cache-folder=$HOME/.npm/.cache/garn \
  --use-yarnrc=$HOME/.garnrc"
```
