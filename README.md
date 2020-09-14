# homeserver

Scripts to automatise installation of the home server

Using samba to have a directory from windows to easily edit traefik config :)

## traefik

- https://hub.docker.com/_/traefik

```bash
# traefik
docker run --restart=always -d --name traefik -p 8080:8080 -p 80:80 -v /var/run/docker.sock:/var/run/docker.sock:ro traefik:v2.2 --providers.docker.exposedbydefault=false

# samba
mkdir -p ~/samba
docker run -d --restart=always --name samba --hostname samba -e USERID=1000 -e GROUPID=1000 -e VETO=yes -p 139:139 -p 445:445 -p 137:137/udp -p 138:138/udp -v ~/:/c dperson/samba -p -n -r -u "c;c" -u "Sarah;c" -s "c;/c;no;no;no;c,Sarah;none;c,Sarah" -W

# netdata
docker run -d --restart always --no-healthcheck --security-opt apparmor=unconfined --name netdata --hostname netdata --cap-add SYS_PTRACE -v /etc/passwd:/host/etc/passwd:ro -v /etc/group:/host/etc/group:ro -v /proc:/host/proc:ro -v /sys:/host/sys:ro -v /etc/os-release:/host/etc/os-release:ro -v /var/run/docker.sock:/var/run/docker.sock:ro -l='traefik.http.routers.netdata.rule=Host(`netdata.192-168-1-5.nip.io`)' -l="traefik.http.services.netdata.loadbalancer.server.port=19999" -l="traefik.enable=true" netdata/netdata

# http://dl.192-168-1-5.nip.io/
mkdir -p ~/docker/aria2-ui/filebrowser/
touch ~/docker/aria2-ui/filebrowser/filebrowser.db
docker run -d --restart=always --name dl -v ~/docker/aria2-ui/filebrowser/filebrowser.db:/app/filebrowser.db -v ~/samba/:/data -e ENABLE_AUTH=true -e ARIA2_USER=c -e ARIA2_PWD=c -e ARIA2_SSL=false -l='traefik.http.routers.dl.rule=Host(`dl.192-168-1-5.nip.io`)' -l="traefik.http.services.dl.loadbalancer.server.port=80" -l="traefik.enable=true" wahyd4/aria2-ui

# watchtower
docker run -d --restart=always --name=watchtower -v=/var/run/docker.sock:/var/run/docker.sock:ro containrrr/watchtower --cleanup

### IGNORE BELLOW ###

# http://draw.192-168-1-5.nip.io/
docker run --restart=always -d --name=draw --expose 8080 -l="traefik.enable=true" chneau/draw

# http://pyload.192-168-1-5.nip.io/
docker run -l="traefik.enable=true" -l="traefik.http.services.pyload.loadbalancer.server.port=8000" --name=pyload -e PUID=1000 -e PGID=1000 -e TZ=Europe/London -v ~/samba:/downloads --restart always -d linuxserver/pyload
```

- http://netdata.192-168-1-5.nip.io/
- http://draw.192-168-1-5.nip.io/
- http://dl.192-168-1-5.nip.io/
- http://pyload.192-168-1-5.nip.io/

```bash
# pyloads needs to have a label to specify port number.
# Plus, we need to specify the service name because a container could returns multiple ports = multiple services (logging, web, api..)

# different examples

docker run --rm -it --name traefik -p 8080:8080 -p 80:80 -v ~/docker/traefik.yml:/etc/traefik/traefik.yml -v /var/run/docker.sock:/var/run/docker.sock:ro traefik:v2.2

docker run --rm -it --name=whoami -l="traefik.enable=true" -l='traefik.http.routers.whoami.rule=Host(`whoami.192-168-1-5.nip.io`)' -l="traefik.http.routers.whoami.entrypoints=http" containous/whoami
docker run --rm -it --name=draw -l="traefik.enable=true" -l='traefik.http.routers.draw.rule=Host(`draw.192-168-1-5.nip.io`)' -l="traefik.http.routers.draw.entrypoints=http" chneau/draw

# net to expose port for traefik, notice that -p 8080 is different than --expose 8080
# https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose
# to have *.nip.io to work on your computer, ensure to use popular dns like 8.8.8.8
```
