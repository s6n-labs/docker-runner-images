#!/usr/bin/env sh

set -eux

./config.sh --unattended --disableupdate $@
./run.sh
