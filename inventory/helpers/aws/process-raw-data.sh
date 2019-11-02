#!/bin/sh

account=$1
region=$2
out=/var/cache/polynimbus/inventory

GET=/opt/polynimbus/drivers/aws/get-raw.sh
SAVE=/opt/polynimbus/common/save.sh

$GET $account --region $region ec2 describe-security-groups           |$SAVE 2 $out raw-aws-sg-$account-$region.json
$GET $account --region $region ec2 describe-nat-gateways              |$SAVE 2 $out raw-aws-nat-$account-$region.json
$GET $account --region $region ec2 describe-network-interfaces        |$SAVE 2 $out raw-aws-ifaces-$account-$region.json
$GET $account --region $region ec2 describe-route-tables              |$SAVE 2 $out raw-aws-route-$account-$region.json
$GET $account --region $region ec2 describe-subnets                   |$SAVE 2 $out raw-aws-subnets-$account-$region.json
$GET $account --region $region ec2 describe-vpcs                      |$SAVE 2 $out raw-aws-vpcs-$account-$region.json
$GET $account --region $region ec2 describe-internet-gateways         |$SAVE 2 $out raw-aws-gws-$account-$region.json
$GET $account --region $region ec2 describe-addresses                 |$SAVE 2 $out raw-aws-addrs-$account-$region.json
$GET $account --region $region ec2 describe-instances                 |$SAVE 2 $out raw-aws-instances-$account-$region.json
$GET $account --region $region ec2 describe-volumes                   |$SAVE 2 $out raw-aws-volumes-$account-$region.json
$GET $account --region $region elb describe-load-balancers            |$SAVE 2 $out raw-aws-elb-$account-$region.json
$GET $account --region $region elbv2 describe-load-balancers          |$SAVE 2 $out raw-aws-elbv2-$account-$region.json
$GET $account --region $region acm list-certificates                  |$SAVE 2 $out raw-aws-certs-$account-$region.json
$GET $account --region $region elasticbeanstalk describe-environments |$SAVE 2 $out raw-aws-beanstalk-$account-$region.json
