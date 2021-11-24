#!/bin/sh

account=$1
out=~/.polynimbus/inventory


/opt/polynimbus/drivers/aws/users/list-iam-users.php $account \
	|/opt/polynimbus/common/save.sh 14 $out users-aws-$account.list

/opt/polynimbus/drivers/aws/users/list-iam-groups.php $account \
	|/opt/polynimbus/common/save.sh 0 $out groups-aws-$account.list

/opt/polynimbus/inventory/helpers/aws/list-iam-memberships.sh $account $out/users-aws-$account.list \
	|/opt/polynimbus/common/save.sh 0 $out membership-aws-$account.list

/opt/polynimbus/inventory/helpers/aws/list-iam-access-keys.sh $account $out/users-aws-$account.list \
	|/opt/polynimbus/common/save.sh 0 $out keys-aws-$account.list



# analyze policies - start with cache warm-up
/opt/polynimbus/drivers/aws/users/list-iam-managed-policies.sh $account >/dev/null

/opt/polynimbus/inventory/helpers/aws/list-iam-policies.sh $account \
	$out/groups-aws-$account.list \
	$out/users-aws-$account.list \
	|/opt/polynimbus/common/save.sh 0 $out policies-aws-$account.list


# iterate over lists of policies and dump policy documents
# (first for groups, then for users; first inline, then managed including built-in ones)

for G in `cat $out/groups-aws-$account.list |cut -d' ' -f1`; do
	for D in `grep "^group $G " $out/policies-aws-$account.list |cut -d' ' -f3- |grep ^: |cut -d: -f2-`; do
		/opt/polynimbus/drivers/aws/users/get-iam-policy-document.php $account group $G $D \
			|/opt/polynimbus/common/save.sh 2 $out policy-aws-$account-group-$G-$D.json
	done

	for D in `grep "^group $G " $out/policies-aws-$account.list |cut -d' ' -f3- |grep -v ^:`; do
		file=policy-aws-$account-managed-$D.json
		if [ ! -s $out/$file ] || [ `stat -c %Y $out/$file` -le `date -d '-4 hours' +%s` ]; then
			/opt/polynimbus/drivers/aws/users/get-iam-policy-document.php $account managed - $D \
				|/opt/polynimbus/common/save.sh 2 $out $file
		fi
	done
done

for U in `cat $out/users-aws-$account.list |cut -d' ' -f1`; do
	for D in `grep "^user $U " $out/policies-aws-$account.list |cut -d' ' -f3- |grep ^: |cut -d: -f2-`; do
		/opt/polynimbus/drivers/aws/users/get-iam-policy-document.php $account user $U $D \
			|/opt/polynimbus/common/save.sh 2 $out policy-aws-$account-user-$U-$D.json
	done

	for D in `grep "^user $U " $out/policies-aws-$account.list |cut -d' ' -f3- |grep -v ^:`; do
		file=policy-aws-$account-managed-$D.json
		if [ ! -s $out/$file ] || [ `stat -c %Y $out/$file` -le `date -d '-4 hours' +%s` ]; then
			/opt/polynimbus/drivers/aws/users/get-iam-policy-document.php $account managed - $D \
				|/opt/polynimbus/common/save.sh 2 $out $file
		fi
	done
done
