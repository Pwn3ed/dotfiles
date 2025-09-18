#!/bin/bash

git clone https://github.com/leonardo-luz/rust-passman-cli

cd rust-passman-cli/

cargo install --path .

cd ..

rm -rf rust-passman-cli
