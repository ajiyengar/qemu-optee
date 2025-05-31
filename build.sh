#!/usr/bin/env bash

set -e -v

ARCHTYPE=$(uname -m)
[[ $ARCHTYPE == arm64* ]] && ARCHTYPE=aarch64

DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check
[[ $ARCHTYPE == aarch64 ]] \
  && DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check_arm64

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
docker run -it --rm \
  -v ~/dockerhome:/home \
  -v /tmp/docker_ccache:/root/.cache/ccache \
  -v .:/work \
  -w /work \
  $DOCKERCONTAINER \
  ./scripts/build_internal.sh
