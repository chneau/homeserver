.SILENT:
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:
.PHONY:

deps:
	ansible-galaxy install -r requirements.yml -p roles/
