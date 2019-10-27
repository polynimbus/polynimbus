#!/bin/sh

mkdir -p   /var/cache/polynimbus/alibaba /root/.aliyuncli
chmod 0700 /var/cache/polynimbus/alibaba

touch /root/.aliyuncli/credentials
chmod 0600 /root/.aliyuncli/credentials

# TODO: these package names are good for Debian/Ubuntu only
/opt/polynimbus/common/install-packages.sh libyaml-dev libpython-dev python-yaml python-pip
/opt/polynimbus/common/install-pip.sh aliyuncli aliyun-python-sdk-ecs
