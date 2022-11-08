#!/usr/bin/env bash
echo "Update apt database"
sudo apt-get update

echo "Adding WASM Targets"
rustup target add wasm32-unknown-unknown
rustup target add wasm32-wasi

echo "Installing Cargo-Watch"
cargo install cargo-watch

echo "Installing WASMCloud Shell"
curl -s https://packagecloud.io/install/repositories/wasmcloud/core/script.deb.sh | sudo bash
sudo apt install wasmcloud wash

echo "Installing WABT"
sudo apt-get -y install wabt

echo "Installing Trunk"
cargo install --locked trunk

echo "Installing uuid and psql for WASMcloud petclinic example"
sudo apt-get -y install uuid-runtime
sudo apt-get -y install postgresql

echo "Done!"