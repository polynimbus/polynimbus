#!/bin/sh

mkdir -p /etc/polynimbus/robot /var/cache/polynimbus/robot
chmod 0700 /var/cache/polynimbus/robot

# TODO: these package names are good for Debian/Ubuntu only
/opt/polynimbus/common/install-packages.sh libyaml-dev libpython-dev python-yaml python-pip
/opt/polynimbus/common/install-pip.sh hetzner
