#!/usr/bin/env sh

set -eux

sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf
sudo -u runner ./config.sh --unattended $@
journalctl -f &
exec /sbin/init
