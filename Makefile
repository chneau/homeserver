.SILENT:
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:
.PHONY:

deps:
	ansible-galaxy install -r requirements.yml -p roles/

docker:
	ansible-playbook -i hosts.yml docker.yml

all:
	ansible all -i hosts.yml -m apt -a "update_cache=yes upgrade=dist force_apt_get=yes" -b

