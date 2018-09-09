#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: save.sh <base-directory> <filename>"
	exit 1
fi

path=$1
file=$path/$2

# First write new file as *.new - so the previous version is still in
# place and will be overwritten only if the new version is not empty.

cat - >$file.new

# Don't save empty files. And treat files up to 20 bytes as empty
# (eg. empty configuration files, with a few newline characters only).

if [ ! -s $file.new ] || [ `stat -c %s $file.new` -lt 20 ]; then
	exit 0
fi

day=`date +%d`
mon=`date +%m`
year=`date +%Y`

copy=$path/$year/${year}${mon}/${year}${mon}${day}

# New file is written into base directory, and then hardlinked
# inside the directory structure. So, the latest non-empty version
# can be always accessed as $2/$3, while all versions (current and
# all previous) are stored inside the directory structure.

mkdir -p $copy
ln -f $file.new $copy/$2
mv -f $file.new $file 2>/dev/null
