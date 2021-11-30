# {{ project-name }} Makefile

CAPABILITY_ID = "wasmcloud:example:{{to_snake_case project-name}}"
NAME = "{{ project-name }}"
VENDOR = "{{ vendor_name }}"
PROJECT = {{ to_snake_case project-name }}
VERSION = 0.1.0
REVISION = 0

include ./provider.mk

test::
	cargo clippy --all-targets --all-features

