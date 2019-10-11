#!/bin/sh

out=/var/cache/polynimbus/inventory

/opt/polynimbus/drivers/aws/list-accounts.sh \
	|grep -vxFf /var/cache/polynimbus/aws/list-users.blacklist \
	|/opt/polynimbus/common/save.sh 0 $out projects-aws.list

for account in `cat $out/projects-aws.list`; do
	/opt/polynimbus/drivers/aws/list-users.php $account \
		|/opt/polynimbus/common/save.sh 14 $out users-aws-$account.list

	/opt/polynimbus/drivers/aws/list-iam-groups.php $account \
		|/opt/polynimbus/common/save.sh 0 $out groups-aws-$account.list

	/opt/polynimbus/drivers/aws/list-managed-policies.sh $account >/dev/null

	for G in `cat $out/groups-aws-$account.list |cut -d' ' -f1`; do
		policies=policies-aws-$account-group-$G.list

		/opt/polynimbus/drivers/aws/list-policies.php $account group $G \
			|/opt/polynimbus/common/save.sh 0 $out $policies

		for D in `grep ^: $out/$policies |cut -d: -f2-`; do
			/opt/polynimbus/drivers/aws/get-policy-document.php $account group $G $D \
				|/opt/polynimbus/common/save.sh 2 $out policy-aws-$account-group-$G-$D.json
		done

		for D in `grep -v ^: $out/$policies`; do
			file=policy-aws-$account-managed-$D.json
			if [ ! -s $out/$file ] || [ `stat -c %Y $out/$file` -le `date -d '-4 hours' +%s` ]; then
				/opt/polynimbus/drivers/aws/get-policy-document.php $account managed - $D \
					|/opt/polynimbus/common/save.sh 2 $out $file
			fi
		done
	done

	for U in `cat $out/users-aws-$account.list |cut -d' ' -f1`; do
		policies=policies-aws-$account-user-$U.list

		/opt/polynimbus/drivers/aws/list-iam-groups.php $account $U \
			|/opt/polynimbus/common/save.sh 0 $out groups-aws-$account-$U.list

		/opt/polynimbus/drivers/aws/list-policies.php $account user $U \
			|/opt/polynimbus/common/save.sh 0 $out $policies

		for D in `grep ^: $out/$policies |cut -d: -f2-`; do
			/opt/polynimbus/drivers/aws/get-policy-document.php $account user $U $D \
				|/opt/polynimbus/common/save.sh 2 $out policy-aws-$account-user-$U-$D.json
		done

		for D in `grep -v ^: $out/$policies`; do
			file=policy-aws-$account-managed-$D.json
			if [ ! -s $out/$file ] || [ `stat -c %Y $out/$file` -le `date -d '-4 hours' +%s` ]; then
				/opt/polynimbus/drivers/aws/get-policy-document.php $account managed - $D \
					|/opt/polynimbus/common/save.sh 2 $out $file
			fi
		done
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


/opt/polynimbus/drivers/google/list-projects.sh default \
	|grep -vxFf /var/cache/polynimbus/google/get-iam-policy.blacklist \
	|/opt/polynimbus/common/save.sh 0 $out projects-google.list

for project in `cat $out/projects-google.list`; do
	/opt/polynimbus/drivers/google/list-users.sh default $project \
		|/opt/polynimbus/common/save.sh 14 $out users-google-$project.list
done
