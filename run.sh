#!/usr/bin/env bash

set -e -v

ARCHTYPE=$(uname -m)
[[ $ARCHTYPE == arm64* ]] && ARCHTYPE=aarch64

DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check
[[ $ARCHTYPE == aarch64 ]] \
  && DOCKERCONTAINER=jforissier/optee_os_ci:qemu_check_arm64

#########################
# Normal world terminal
#########################
setsid "${TERMINAL}" -e \
  docker run -it --rm \
  --name optee \
  -v ~/dockerhome:/home \
  -v /tmp/docker_ccache:/root/.cache/ccache \
  -v .:/work \
  -w /work \
  $DOCKERCONTAINER \
  ./scripts/term_normal.sh &

#########################
# Secure world terminal
#########################
setsid "${TERMINAL}" -e \
  docker exec -it optee \
  ./scripts/term_secure.sh &

#########################
# Launch QEMU
#########################
sleep 5
setsid "${TERMINAL}" -e \
  docker exec -it optee \
  ./scripts/launch_qemu.sh &
