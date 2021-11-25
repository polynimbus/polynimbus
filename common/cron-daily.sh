#!/bin/sh

/opt/polynimbus/drivers/aws/internal/download-ami-table.sh \
	|/opt/polynimbus/common/save.sh 14 ~/.polynimbus/cache/aws ubuntu-ec2-images.json

/opt/polynimbus/drivers/aws/internal/download-instance-types.sh \
	|/opt/polynimbus/common/save.sh 14 ~/.polynimbus/cache/aws ec2-instance-types.html
