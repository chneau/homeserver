# homeserver

Scripts to automatise installation of the home server

Using samba to have a directory from windows to easily edit traefik config :)

## SIMPLIFIED

```bash
# hdd mount
sudo mount /dev/sda1 ~/samba/hdd -t exfat -o uid=c,gid=c

# samba
docker run \
    --detach \
    --restart always \
    --no-healthcheck \
    --security-opt apparmor=unconfined \
    --name samba \
    --hostname samba \
    --volume ~/samba:/c \
    --env USERID=1000 \
    --env GROUPID=1000 \
    --env VETO=yes \
    --net host \
    dperson/samba -p -n -r -u "c;c" -u "Sarah;c" -s "c;/c;no;no;no;c,Sarah;none;c,Sarah" -W -S

# dl
docker run \
    --detach \
    --restart always \
    --no-healthcheck \
    --security-opt apparmor=unconfined \
    --name dl \
    --hostname dl \
    --volume ~/docker/aria2/conf/:/aria2/conf/ \
    --volume ~/samba/:/aria2/data/ \
    --env PUID=1000 \
    --env PGID=1000 \
    --env ARIA2RPCPORT=80 \
    --publish 0.0.0.0:80:8080 \
    hurlenko/aria2-ariang
```
