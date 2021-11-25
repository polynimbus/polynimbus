#!/bin/sh

# TODO: detect trial account expiration:
#
#       "inactive-status": null,
#       "lifecycle-state": "ACTIVE",
#

if [ -s ~/.oci/config ] && [ "`oci iam compartment list 2>/dev/null |grep ACTIVE`" = "" ]; then
	echo "error: Oracle Cloud account not configured, or without active subscriptions"
fi
