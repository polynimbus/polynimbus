#!/bin/sh

out=/var/cache/polynimbus/inventory

accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-users.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/list-users.php $account \
		|/opt/polynimbus/common/save.sh 14 $out users-aws-$account.list

	/opt/polynimbus/drivers/aws/list-iam-groups.php $account \
		|/opt/polynimbus/common/save.sh 0 $out groups-aws-$account.list

	for G in `cat $out/groups-aws-$account.list |cut -d' ' -f1`; do
		/opt/polynimbus/drivers/aws/list-attached-policies.php $account group $G \
			|/opt/polynimbus/common/save.sh 0 $out policies-aws-$account-group-$G.list
	done

	for U in `cat $out/users-aws-$account.list |cut -d' ' -f1`; do
		/opt/polynimbus/drivers/aws/list-attached-policies.php $account user $U \
			|/opt/polynimbus/common/save.sh 0 $out policies-aws-$account-user-$U.list
		/opt/polynimbus/drivers/aws/list-iam-groups.php $account $U \
			|/opt/polynimbus/common/save.sh 0 $out groups-aws-$account-$U.list
	done
done


accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-sg.blacklist`
for account in $accounts; do
	/opt/polynimbus/drivers/aws/list-security-groups.php $account --raw \
		|/opt/polynimbus/common/save.sh 14 $out acl-aws-$account.json
done


accounts=`/opt/polynimbus/drivers/aws/list-accounts.sh |grep -vxFf /var/cache/polynimbus/aws/list-zones.blacklist`
for account in $accounts; do
	map=`/opt/polynimbus/drivers/aws/list-zones.php $account --map`
	for entry in $map; do
		domain=`echo $entry |cut -d: -f1`
		zoneid=`echo $entry |cut -d: -f2`
		/opt/polynimbus/drivers/aws/list-records.php $account $zoneid \
			|/opt/polynimbus/common/save.sh 14 $out zone-aws-$account-$domain.zone
	done
done


projects=`/opt/polynimbus/drivers/google/list-projects.sh default |grep -vxFf /var/cache/polynimbus/google/get-iam-policy.blacklist`
for project in $projects; do
	/opt/polynimbus/drivers/google/list-users.sh default $project \
		|/opt/polynimbus/common/save.sh 14 $out users-google-$project.list
done
