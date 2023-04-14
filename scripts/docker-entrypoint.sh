#!/usr/bin/env sh

set -eux

./config.sh --unattended $@
./run.sh
