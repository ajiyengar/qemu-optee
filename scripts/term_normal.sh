#!/usr/bin/env bash

set -e -v

apt install -y ncat

cd optee/build || return
./soc_term.py 54320
