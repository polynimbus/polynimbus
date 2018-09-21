#!/bin/sh

/opt/polynimbus/api/v1/all/list-instances.sh \
	|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory instances.list
