.PHONY = update-lock
WASH ?= $(shell which wash)

# Folder name of actor under actor/
RUST_ACTORS = echo hello

update-locks: ## Generates Rust actor projects and computes Cargo lock files
	for rust_actor in $(RUST_ACTORS) ; do \
		$(WASH) new actor -p actor/$$rust_actor $$rust_actor --silent; \
		pushd $$rust_actor && cargo update && popd; \
		cp $$rust_actor/Cargo.lock actor/$$rust_actor; \
		rm -rf $$rust_actor; \
	done