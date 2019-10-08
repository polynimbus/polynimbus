#!/bin/sh

/opt/polynimbus/drivers/aws/internal/download-ami-table.sh \
	|/opt/polynimbus/common/save.sh 14 /var/cache/polynimbus/aws ubuntu-ec2-images.json

/opt/polynimbus/drivers/aws/internal/download-instance-types.sh \
	|/opt/polynimbus/common/save.sh 14 /var/cache/polynimbus/aws ec2-instance-types.html
