#!/bin/bash

if [ "$4" = "" ]; then
	echo "usage: $0 <cloud-account> <role-arn> <mfa-arn> <mfa-token>"
	exit 1
elif ! grep -q "\[$1\]" /root/.aws/credentials; then
	echo "error: cloud account \"$1\" not configured"
	exit 1
elif ! [[ $4 =~ ^[0-9]{6}$ ]]; then
	echo "error: parameter $4 not conforming mfa token code format"
	exit 1
fi

account=$1
role_arn=$2
mfa_arn=$3
token=$4

tmpfile=`mktemp`
aws sts assume-role \
	--profile $account \
	--serial-number $mfa_arn \
	--token-code $token \
	--role-arn $role_arn \
	--role-session-name "`basename $role_arn`Session" \
	--duration-seconds 43200 \
	--output json >$tmpfile

if [ $? -eq 0 ]; then
	sed -i -e "/\[$account\]/,+3 d" /root/.aws/credentials

	AWS_SESSION_TOKEN=`cat $tmpfile |jq -r '.Credentials.SessionToken'`
	AWS_ACCESS_KEY_ID=`cat $tmpfile |jq -r '.Credentials.AccessKeyId'`
	AWS_SECRET_ACCESS_KEY=`cat $tmpfile |jq -r '.Credentials.SecretAccessKey'`

	echo "[$account]
aws_session_token = ${AWS_SESSION_TOKEN}
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
" >>/root/.aws/credentials
fi
