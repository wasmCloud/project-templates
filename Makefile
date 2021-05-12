COLOR ?= always # Valid COLOR options: {always, auto, never}
CARGO = cargo --color $(COLOR)
TARGET = target/wasm32-unknown-unknown
DEBUG = $(TARGET)/debug
RELEASE = $(TARGET)/release
KEYDIR ?= .keys
VERSION = $(shell cargo metadata --no-deps --format-version 1 | jq -r '.packages[].version')
# Increment debug revision by 1 each time, defaulting to zero otherwise
REVISION ?= $(shell test -f $(DEBUG)/{{crate_name}}.wasm && wash claims inspect $(DEBUG)/{{crate_name}}_s.wasm -o json | jq '.revision')
ifeq ($(REVISION),)
REVISION := -1
endif

.PHONY: all build check clean doc test update

all: build

build:
	@$(CARGO) build
	wash claims sign $(DEBUG)/{{crate_name}}.wasm --name "{{crate_name}}" --ver $(VERSION) --rev $$(( $(REVISION) + 1 ))
	wash claims inspect $(DEBUG)/{{crate_name}}_s.wasm

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
	wash claims sign $(RELEASE)/{{crate_name}}.wasm --name "{{crate_name}}" --ver $(VERSION) --rev 0
	wash claims inspect $(RELEASE)/{{crate_name}}_s.wasm

test: build
	@$(CARGO) test

update:
	@$(CARGO) update