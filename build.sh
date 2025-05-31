#!/usr/bin/env bash

set -e

###############
# Patch
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
# Docker Build
###############
docker run -it \
  -v ~/dockerhome:/home \
  -v .:/work \
  -v /tmp/docker_ccache:/work/.cache/ccache \
  -w /work \
  jforissier/optee_os_ci:qemu_check_arm64 \
  ./docker_build_optee.sh

# --rm --name optee \
