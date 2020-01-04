#!/bin/sh

mkdir -p /etc/polynimbus/b2

/opt/polynimbus/common/install-packages.sh python-pip
/opt/polynimbus/common/install-pip.sh b2
