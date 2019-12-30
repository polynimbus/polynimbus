#!/bin/sh

compartment=`/opt/polynimbus/drivers/oracle/compute/get-compartment-id.sh`

if [ "$1" = "--full" ]; then
	oci compute instance list --compartment-id $compartment --all
else
	oci compute instance list --compartment-id $compartment --all \
		|/opt/polynimbus/drivers/oracle/internal/parse-instances.php
fi
