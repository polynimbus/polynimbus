#!/bin/sh

gcloud compute instances list --format json \
	|/opt/polynimbus/drivers/google/internal/parse-instances.php
