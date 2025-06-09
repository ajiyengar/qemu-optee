#!/usr/bin/env bash

set -e -v

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
export BR2_CCACHE_DIR=/root/.cache/ccache

###############
#  Launch QEMU
###############
make -C optee/build run-only LAUNCH_TERMINAL=false
