#!/bin/sh

mkdir -p /etc/polynimbus/alibaba /var/cache/polynimbus/alibaba

# TODO: these package names are good for Debian/Ubuntu only
/opt/polynimbus/common/install-packages.sh libyaml-dev libpython-dev python-yaml python-pip

echo "checking for pip package aliyun-python-sdk-ecs"
if [ "`pip list |grep aliyun-python-sdk-ecs`" = "" ]; then
	pip install aliyuncli aliyun-python-sdk-ecs
else
	pip install --upgrade aliyuncli aliyun-python-sdk-ecs
fi
