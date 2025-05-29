#!/usr/bin/env bash

set -e

###############
# Setup
###############
git config --global user.name "CI user"
git config --global user.email "ci@invalid"
git config --global color.ui false

###############
# Sync
###############
repo --color=never init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml -b 4.6.0
repo --color=never sync -j4
make -C build -j3 toolchains

###############
# Build
###############
make -C build -j $(nproc) 2>&1 | tee build.log
