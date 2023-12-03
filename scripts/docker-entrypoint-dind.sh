#!/usr/bin/env sh

set -eux

sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf
sudo -u runner ./config.sh --unattended --disableupdate $@
journalctl -f &
exec /sbin/init
