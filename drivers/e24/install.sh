#!/bin/sh

mkdir -p /etc/polynimbus/e24 /var/cache/polynimbus/e24

if [ ! -d /usr/share/php/sdk-1.6.2 ]; then
	echo "installing aws-sdk"
	mkdir -p /usr/share/php
	cd /usr/share/php
	wget http://pear.amazonwebservices.com/get/sdk-latest.zip
	unzip -b sdk-latest.zip
fi
