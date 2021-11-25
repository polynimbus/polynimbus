#!/bin/sh

if [ "`which az 2>/dev/null`" != "" ] && [ -f ~/.azure/accessTokens.json ]; then
	ls ~/.polynimbus/accounts/azure |sed s/.sh//g
fi
