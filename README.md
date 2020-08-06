# homeserver

Scripts to automatise installation of the home server

## traefik

- https://hub.docker.com/_/traefik

```yml
## traefik.yml

# Docker configuration backend
providers:
  docker:
    defaultRule: "Host(`{{ trimPrefix `/` .Name }}.192-168-1-5.nip.io`)"

# API and dashboard configuration
api:
  insecure: true
```

```bash
docker run --restart=always -d --name traefik -p 8080:8080 -p 80:80 -v $PWD/traefik.yml:/etc/traefik/traefik.yml -v /var/run/docker.sock:/var/run/docker.sock:ro traefik:v2.2
docker run --restart=always -d --name traefik -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock:ro traefik:v2.2 --api.insecure=true --providers.docker.defaultRule='Host(`{{ trimPrefix `/` .Name }}.192-168-1-5.nip.io`)'
docker run --rm -it --name traefik -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock:ro traefik:v2.2 --api.insecure=true --providers.docker.defaultRule='Host(`{{ trimPrefix `/` .Name }}.192-168-1-5.nip.io`)'
docker run --rm -it --name=whoami -l="traefik.enable=true" -l='traefik.http.routers.whoami.rule=Host(`whoami.192-168-1-5.nip.io`)' -l="traefik.http.routers.whoami.entrypoints=http" containous/whoami
docker run --rm -it --name=draw -l="traefik.enable=true" -l='traefik.http.routers.whoami.rule=Host(`whoami.192-168-1-5.nip.io`)' -l="traefik.http.routers.draw.entrypoints=http" chneau/draw

# net to expose port for traefik, notice that -p 8080 is different than --expose 8080
# https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose
docker run --restart=always -d --name=draw --expose 8080 chneau/draw
docker run -d --restart always --no-healthcheck --security-opt apparmor=unconfined --name netdata --hostname netdata --cap-add SYS_PTRACE -v /etc/passwd:/host/etc/passwd:ro -v /etc/group:/host/etc/group:ro -v /proc:/host/proc:ro -v /sys:/host/sys:ro -v /etc/os-release:/host/etc/os-release:ro -v /var/run/docker.sock:/var/run/docker.sock:ro --expose 19999 netdata/netdata
```

- http://netdata.192-168-1-5.nip.io/
- http://draw.192-168-1-5.nip.io/
