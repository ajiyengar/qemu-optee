#!/usr/bin/env bash

set -e

###############
# Sync
###############
repo init --no-clone-bundle -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
repo sync -j4 --no-clone-bundle
make -C build -j2 toolchains

###############
# Build
###############
make -C build -j $(nproc) 2>&1 | tee build.log
