#!/bin/sh

if [ "`which az 2>/dev/null`" != "" ] && [ -f /root/.azure/accessTokens.json ]; then
	ls /etc/polynimbus/azure |sed s/.sh//g
fi
