#!/usr/bin/env bash

set -e -v

###############
# Setup
###############
git config --global user.name "CI user"
git config --global user.email "ci@invalid"
git config --global color.ui false
export LC_ALL=C
apt install -y ncat
export FORCE_UNSAFE_CONFIGURE=1 # Prevent Buildroot error when building as root
export BR2_CCACHE_DIR=/root/.cache/ccache
rm /work/build.log 2>/dev/null || true

###############
# Sync
###############
# repo --color=never init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml -b 4.6.0
# repo --color=never sync -j$(nproc)
# make -C build -j$(nproc) toolchains 2>&1 | tee -a build.log
/root/get_optee.sh qemu_v8

###############
# Patch **TEMPLATE**
###############
# set +e
# # patch --binary -d edk2 -p1 -N -i \
#   ../0001-edk2-enable-debug-O0.patch -r-
# [[ $? -gt 1 ]] \
#   && {
#     echo "ERR: EDK2 patch failed"
#     exit 0
#   }
# set -e

###############
# Build
###############
make -C optee/build -j$(nproc) 2>&1 | tee -a /work/build.log
cp -R /root/optee/ /work/
#/bin/bash
