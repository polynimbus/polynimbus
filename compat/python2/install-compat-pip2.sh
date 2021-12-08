#!/bin/sh

# https://blog.emacsos.com/pip2-in-debian-11-bullseye.html

if [ ! -x /usr/bin/pip ] && [ ! -x /usr/local/bin/pip ]; then
	python2 /opt/polynimbus/compat/python2/pip/2.7/get-pip.py
fi
