#!/usr/bin/env sh

set -eux

sudo -u runner ./config.sh --unattended $@
exec /sbin/init &
cat /var/log/syslog
