#!/bin/sh

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-users.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/list-users.php $account \
		|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory users-aws-$account.list
done

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-sg.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/list-security-groups.php $account --raw \
		|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory acl-aws-$account.json
done

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-zones.blacklist`
for account in $accounts; do
	map=`/opt/polynimbus/drivers/aws/list-zones.php $account --map`
	for entry in $map; do
		domain=`echo $entry |cut -d: -f1`
		zoneid=`echo $entry |cut -d: -f2`
		/opt/polynimbus/drivers/aws/list-records.php $account $zoneid \
			|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory zone-aws-$account-$domain.zone
	done
done

projects=`/opt/polynimbus/drivers/google/list-projects.sh default |grep -vxFf /var/cache/polynimbus/google/get-iam-policy.blacklist`
for project in $projects; do
	/opt/polynimbus/drivers/google/list-users.sh default $project \
		|/opt/polynimbus/common/save.sh /var/cache/polynimbus/inventory users-google-$project.list
done
