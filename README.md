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
