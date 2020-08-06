# homeserver

Scripts to automatise installation of the home server

## traefik

- https://hub.docker.com/_/traefik

```yml
## traefik.yml

# Docker configuration backend
providers:
  docker:
    defaultRule: "Host(`{{ trimPrefix `/` .Name }}.docker.localhost`)"

# API and dashboard configuration
api:
  insecure: true
```

```bash
docker run --restart=always -d --name traefik -p 8080:8080 -p 80:80 -v $PWD/traefik.yml:/etc/traefik/traefik.yml -v /var/run/docker.sock:/var/run/docker.sock:ro traefik:v2.2
docker run --restart=always -d --name traefik -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock:ro traefik:v2.2 --api.insecure=true --providers.docker.defaultRule='Host(`{{ trimPrefix `/` .Name }}.docker.localhost`)'
docker run --rm -it --name=whoami -l="traefik.enable=true" -l='traefik.http.routers.whoami.rule=Host(`whoami.localhost`)' -l="traefik.http.routers.whoami.entrypoints=http" containous/whoami
```
