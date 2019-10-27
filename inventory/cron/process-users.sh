#!/bin/sh

out=/var/cache/polynimbus/inventory


/opt/polynimbus/inventory/helpers/aws/list-accounts.sh \
	|/opt/polynimbus/common/save.sh 0 $out projects-aws.list

for account in `cat $out/projects-aws.list |cut -d' ' -f1`; do
	/opt/polynimbus/inventory/helpers/aws/process-iam-data.sh $account
done


/opt/polynimbus/inventory/helpers/list-encryption-keys.sh \
	|/opt/polynimbus/common/save.sh 0 $out encryption-keys.list



/opt/polynimbus/drivers/google/list-projects.sh default \
	|grep -vxFf /var/cache/polynimbus/google/get-iam-policy.blacklist \
	|/opt/polynimbus/common/save.sh 0 $out projects-google.list

for project in `cat $out/projects-google.list`; do
	/opt/polynimbus/drivers/google/list-users.sh default $project \
		|/opt/polynimbus/common/save.sh 14 $out users-google-$project.list
done
