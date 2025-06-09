#!/usr/bin/env bash

set -e -v

ARCHTYPE=$(uname -m)
[[ $ARCHTYPE == arm64* ]] && ARCHTYPE=aarch64

DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check
[[ $ARCHTYPE == aarch64 ]] \
  && DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check_arm64

: "${DOCKERHOME:=~/dockerhome}"

#########################
# Normal world terminal
#########################
setsid "${TERMINAL}" -e \
  docker run -it --rm \
  --name optee \
  -v /tmp/docker_ccache:/root/.cache/ccache \
  -v "$DOCKERHOME":/home \
  -v .:/work \
  -v ./optee:/root/optee \
  -w /root \
  $DOCKERCONTAINER \
  /work/scripts/term_normal.sh &

#########################
# Secure world terminal
#########################
sleep 5
setsid "${TERMINAL}" -e \
  docker exec -it optee \
  /work/scripts/term_secure.sh &

#########################
# Launch QEMU
#########################
sleep 5
setsid "${TERMINAL}" -e \
  docker exec -it optee \
  /work/scripts/launch_qemu.sh &
