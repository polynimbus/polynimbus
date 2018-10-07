#!/bin/sh

/opt/polynimbus/drivers/aws/internal/download-ami-table.sh \
	|/opt/polynimbus/common/save.sh /var/cache/polynimbus/aws ubuntu-ec2-images.json

/opt/polynimbus/drivers/aws/internal/download-instance-types.sh \
	|/opt/polynimbus/common/save.sh /var/cache/polynimbus/aws ec2-instance-types.html

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/list-users.php $account \
		|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory users-aws-$account.list
done
