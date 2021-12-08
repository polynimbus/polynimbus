#!/bin/sh

mkdir -p ~/.polynimbus/accounts/robot ~/.polynimbus/cache/robot
chmod 0700 ~/.polynimbus/cache/robot

# TODO: these package names are good for Debian/Ubuntu only
/opt/polynimbus/common/install-packages.sh libyaml-dev libpython2-dev python2
/opt/polynimbus/compat/python2/install-compat-pip2.sh
/opt/polynimbus/common/install-pip.sh hetzner
