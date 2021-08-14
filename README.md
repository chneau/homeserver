# homeserver

Scripts to automatise installation of the home server

Using samba to have a directory from windows to easily edit traefik config :)

## SIMPLIFIED

```bash
# hdd mount
sudo mount /dev/sda1 ~/samba/hdd -t exfat -o uid=c,gid=c

# get docker-compose with brew install, then run
docker-compose up --detach
```
