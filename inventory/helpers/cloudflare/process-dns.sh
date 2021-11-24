#!/bin/bash

account=$1
out=~/.polynimbus/inventory

CF=/opt/polynimbus/drivers/cloudflare/get.sh
SAVE=/opt/polynimbus/common/save.sh


map=`cat $out/zones.list |grep "^cloudflare $account " |awk '{ print $3 ":" $4 }'`
for entry in $map; do

	domain="${entry%:*}"
	zoneid="${entry##*:}"

	/opt/polynimbus/api/v1/zone/list-records.sh cloudflare $account $zoneid \
		|$SAVE 10 $out zone-cloudflare-$account-$domain.zone

	/opt/polynimbus/api/v1/zone/list-records.sh cloudflare $account $zoneid --raw \
		|$SAVE 10 $out raw-cloudflare-zone-records-$account-$domain.json

	$CF $account zones/$zoneid/available_plans       |python -m json.tool |$SAVE  10 $out raw-cloudflare-zone-plans-$account-$domain.json
	$CF $account zones/$zoneid/subscriptions         |python -m json.tool |$SAVE 160 $out raw-cloudflare-zone-subscriptions-$account-$domain.json
	$CF $account zones/$zoneid/settings              |python -m json.tool |$SAVE  10 $out raw-cloudflare-zone-settings-$account-$domain.json
	$CF $account zones/$zoneid/analytics/dashboard   |python -m json.tool |$SAVE  10 $out raw-cloudflare-zone-analytics-$account-$domain.json
	$CF $account zones/$zoneid/ssl/certificate_packs |python -m json.tool |$SAVE  10 $out raw-cloudflare-zone-certificates-$account-$domain.json
	$CF $account zones/$zoneid/pagerules             |python -m json.tool |$SAVE 100 $out raw-cloudflare-zone-pagerules-$account-$domain.json
	$CF $account zones/$zoneid/rate_limits           |python -m json.tool |$SAVE 250 $out raw-cloudflare-zone-ratelimits-$account-$domain.json
	$CF $account zones/$zoneid/firewall/rules        |python -m json.tool |$SAVE 250 $out raw-cloudflare-zone-firewall-$account-$domain.json
	$CF $account zones/$zoneid/filters               |python -m json.tool |$SAVE 250 $out raw-cloudflare-zone-filters-$account-$domain.json
	$CF $account zones/$zoneid/load_balancers        |python -m json.tool |$SAVE 100 $out raw-cloudflare-zone-balancers-$account-$domain.json
done


# TODO: consider moving this to separate script, run by cron/process-users.sh

$CF $account user               |python -m json.tool |$SAVE  10 $out raw-cloudflare-user-$account.json
$CF $account user/organizations |python -m json.tool |$SAVE  10 $out raw-cloudflare-organizations-$account.json
$CF $account user/subscriptions |python -m json.tool |$SAVE 160 $out raw-cloudflare-subscriptions-$account.json
$CF $account user/audit_logs    |python -m json.tool |$SAVE  10 $out raw-cloudflare-auditlogs-$account.json
$CF $account memberships        |python -m json.tool |$SAVE  10 $out raw-cloudflare-memberships-$account.json
$CF $account railguns           |python -m json.tool |$SAVE 250 $out raw-cloudflare-railguns-$account.json

/opt/polynimbus/drivers/cloudflare/list-connected-accounts.sh $account --raw \
	|$SAVE 10 $out raw-cloudflare-accounts-$account.json

connected=`/opt/polynimbus/drivers/cloudflare/list-connected-accounts.sh $account`
for ID in $connected; do

	$CF $account accounts/$ID/subscriptions     |python -m json.tool |$SAVE 160 $out raw-cloudflare-account-subscriptions-$account-$ID.json
	$CF $account accounts/$ID/registrar/domains |python -m json.tool |$SAVE 100 $out raw-cloudflare-account-domains-$account-$ID.json
done
