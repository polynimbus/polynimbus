#!/bin/sh

mkdir -p /etc/polynimbus/robot ~/.polynimbus/cache/robot
chmod 0700 ~/.polynimbus/cache/robot

# TODO: these package names are good for Debian/Ubuntu only
/opt/polynimbus/common/install-packages.sh libyaml-dev libpython-dev python-yaml python-pip
/opt/polynimbus/common/install-pip.sh hetzner
