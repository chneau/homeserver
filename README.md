# homeserver

My home server simple docker compose:

- deconz to have a zigbee gateway with https://phoscon.de/en/conbee2
- home-assistant to have a nice android app to control the deconz devices
- aria2 with a nice UI to download files
- samba, to retrieve these files from my other computers

```bash
# hdd mount
sudo mount /dev/sda1 ~/samba/hdd -t exfat -o uid=c,gid=c

# get docker-compose with brew (at least it's up to date), then run
docker-compose up --detach
```

## docker run cli command line version

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
    --volume ~/data/:/aria2/data/ \
    --env PUID=1000 \
    --env PGID=1000 \
    --env ARIA2RPCPORT=80 \
    --publish 0.0.0.0:80:8080 \
    hurlenko/aria2-ariang
```
