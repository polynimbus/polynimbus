#!/bin/bash

if [ "`which gcloud 2>/dev/null`" = "" ] && [ -f /root/google-cloud-sdk/path.bash.inc ]; then
	. /root/google-cloud-sdk/path.bash.inc
fi

gcloud compute instances list --format json \
	|/opt/polynimbus/drivers/google/internal/parse-instances.php
