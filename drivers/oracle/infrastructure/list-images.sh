#!/bin/bash
. ~/.polynimbus/accounts/oracle/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <unused> [system-version] [--full]"
	exit 1
fi

compartment=`/opt/polynimbus/drivers/oracle/get-compartment-id.sh`

#
# 1. set caching details
#
if [ "$2" != "" ] && [[ $2 =~ ^[0-9.]+$ ]]; then
	version=$2
	file=~/.polynimbus/cache/oracle/images-$version.cache
else
	version=""
	file=~/.polynimbus/cache/oracle/images.cache
fi

#
# 2. get image list either for all Ubuntu versions or given one
#
if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-8 hours' +%s` ]; then
	if [ "$version" != "" ]; then
		oci compute image list --compartment-id $compartment --all --operating-system "$OCI_SYSTEM" --operating-system-version "$version" >$file
	else
		oci compute image list --compartment-id $compartment --all --operating-system "$OCI_SYSTEM" >$file
	fi
fi

#
# 3. add image ids to map (to allow reversing no-longer-existing ids to system version)
#
cat $file |/opt/polynimbus/drivers/oracle/internal/parse-images.php ~/.polynimbus/cache/oracle/images.map

#
# 4. return images list
#
if [ "$3" = "--full" ]; then
	cat $file
else
	grep '"id":' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g
fi
