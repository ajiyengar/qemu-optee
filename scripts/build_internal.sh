#!/usr/bin/env bash

set -e

###############
# Setup
###############
git config --global user.name "CI user"
git config --global user.email "ci@invalid"
git config --global color.ui false
export LC_ALL=C
export LANG=C.UTF_8
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
apt install -y ncat
export FORCE_UNSAFE_CONFIGURE=1 # Prevent Buildroot error when building as root
export BR2_CCACHE_DIR=/work/.cache/ccache

################
## Sync
################
repo --color=never init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml -b 4.6.0
repo --color=never sync -j$(nproc)
make -C build -j$(nproc) toolchains 2>&1 | tee build.log
#make -C build -j$(nproc) toolchains && rm -f build/toolchains/gcc*.tar.xz

###############
# Build
###############
#make -C build -j $(nproc) 2>&1 | tee build.log
