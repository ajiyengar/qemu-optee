#!/usr/bin/env bash

set -e -v

ARCHTYPE=$(uname -m)
[[ $ARCHTYPE == arm64* ]] && ARCHTYPE=aarch64

DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check
[[ $ARCHTYPE == aarch64 ]] \
  && DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check_arm64

: "${DOCKERHOME:=~/dockerhome}"

###############
# Docker Build
###############
docker run -it --rm \
  -v "$DOCKERHOME":/home \
  -v /tmp/docker_ccache:/root/.cache/ccache \
  -v .:/work \
  -w /root \
  $DOCKERCONTAINER \
  /work/scripts/build_internal.sh
