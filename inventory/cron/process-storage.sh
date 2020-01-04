#!/bin/sh

out=/var/cache/polynimbus/inventory
file=storage.list

/opt/polynimbus/inventory/helpers/list-storage.sh \
	|/opt/polynimbus/common/save.sh 0 $out $file

/opt/polynimbus/inventory/helpers/aws/process-storage.sh $out/$file
/opt/polynimbus/inventory/helpers/azure/process-storage.sh $out/$file
/opt/polynimbus/inventory/helpers/b2/process-storage.sh $out/$file
