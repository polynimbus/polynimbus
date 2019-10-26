#!/bin/sh

out=/var/cache/polynimbus/inventory

# TODO: add also queues and nosql data sources here

/opt/polynimbus/api/v1/all/list-databases.sh 2>/dev/null \
	|/opt/polynimbus/common/save.sh 0 $out databases.list
