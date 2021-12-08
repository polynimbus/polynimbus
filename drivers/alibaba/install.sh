#!/bin/sh

mkdir -p   ~/.polynimbus/cache/alibaba ~/.aliyuncli
chmod 0700 ~/.polynimbus/cache/alibaba

touch ~/.aliyuncli/credentials
chmod 0600 ~/.aliyuncli/credentials

# TODO: these package names are good for Debian/Ubuntu only
/opt/polynimbus/common/install-packages.sh libyaml-dev libpython2-dev python2
/opt/polynimbus/compat/python2/install-compat-pip2.sh
/opt/polynimbus/common/install-pip.sh aliyuncli aliyun-python-sdk-ecs
