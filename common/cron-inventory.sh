#!/bin/sh

/opt/polynimbus/api/v1/all/list-instances.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh /var/cache/polynimbus/web instances.list
