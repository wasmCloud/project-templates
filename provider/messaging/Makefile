PROJECT = {{ to_snake_case project-name }}
NAME = "{{ project-name }}"
VENDOR = "{{ vendor_name }}"
CAPABILITY_ID = wasmcloud:messaging
VERSION  = $(shell cargo metadata --no-deps --format-version 1 | jq -r '.packages[] .version' | head -1)
REVISION = 0
oci_url  = localhost:5000/v2/$(PROJECT):$(VERSION)

include provider.mk