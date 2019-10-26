#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/aws/list-trails.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh 0 $out trails.list
