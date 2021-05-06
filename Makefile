COLOR ?= always # Valid COLOR options: {always, auto, never}
CARGO = cargo --color $(COLOR)
TARGET = target/wasm32-unknown-unknown
DEBUG = $(TARGET)/debug
RELEASE = $(TARGET)/release
KEYDIR ?= .keys
VERSION = $(shell cargo metadata --no-deps --format-version 1 | jq -r '.packages[].version')

.PHONY: all build check clean doc test update

all: build

build:
	@$(CARGO) build	
	wash claims sign $(DEBUG)/{{crate_name}}.wasm -c wasmcloud:httpserver --name "{{crate_name}}" --ver $(VERSION) --rev 0

check:
	@$(CARGO) check

clean:
	@$(CARGO) clean

doc:
	@$(CARGO) doc

inspect:
	wash claims inspect $(RELEASE)/{{crate_name}}_s.wasm

release:
	@$(CARGO) build --release	
	wash claims sign $(RELEASE)/{{crate_name}}.wasm -c wasmcloud:httpserver --name "{{crate_name}}" --ver $(VERSION) --rev 0
	wash claims inspect $(RELEASE)/{{crate_name}}_s.wasm

test: build
	@$(CARGO) test

update:
	@$(CARGO) update