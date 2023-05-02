# {{ project-name }} Makefile

CAPABILITY_ID = "{{capability_id}}"
NAME = "{{ project-name }}"
VENDOR = "{{ vendor_name }}"
PROJECT = {{ to_snake_case project-name }}
VERSION = 0.1.0
REVISION = 0

EXECUTABLES = go goreleaser wash
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH, please install.")))

all: build sign

build:
	goreleaser build --clean --snapshot

sign:
	wash par create --arch x86_64-macos   --binary dist/$(PROJECT)_darwin_amd64_v1/$(PROJECT) --capid $(CAPABILITY_ID) --name $(NAME) --vendor $(VENDOR) --version $(VERSION) --revision $(REVISION) --destination dist/$(PROJECT).par.gz
	wash par insert --arch aarch64-macos  --binary dist/$(PROJECT)_darwin_arm64/$(PROJECT)   dist/$(PROJECT).par.gz
	wash par insert --arch x86_64-linux   --binary dist/$(PROJECT)_linux_amd64_v1/$(PROJECT) dist/$(PROJECT).par.gz
	wash par insert --arch aarch64-linux  --binary dist/$(PROJECT)_linux_arm64/$(PROJECT)    dist/$(PROJECT).par.gz
	wash par insert --arch x86_64-windows --binary dist/$(PROJECT)_windows_amd64_v1/$(PROJECT).exe dist/$(PROJECT).par.gz
	wash par inspect dist/$(PROJECT).par.gz

test:
	go test -v ./...


