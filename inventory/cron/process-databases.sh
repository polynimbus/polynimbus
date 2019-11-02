#!/bin/sh

out=/var/cache/polynimbus/inventory

# TODO: add also queues and nosql data sources here

/opt/polynimbus/inventory/helpers/list-databases.sh \
	|/opt/polynimbus/common/save.sh 0 $out databases.list

/opt/polynimbus/inventory/helpers/list-nosql.sh \
	|/opt/polynimbus/common/save.sh 0 $out nosql.list
