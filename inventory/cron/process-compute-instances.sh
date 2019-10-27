#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/inventory/helpers/list-instances.sh \
	|/opt/polynimbus/common/save.sh 14 $out instances.list

/opt/polynimbus/inventory/helpers/aws/resolve-ami-images.sh
