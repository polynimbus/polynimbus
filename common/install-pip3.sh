#!/bin/sh

install_pip3() {
	pkg=$1
	echo "checking for pip3 package $pkg"
	if [ "`pip3 list |grep $pkg`" = "" ]; then
		pip3 install $pkg
	else
		pip3 install --upgrade $pkg
	fi
}


if [ "$1" = "" ]; then
	echo "usage: $0 <package> [package] [...]"
	exit
fi

for package in $@; do
	install_pip3 $package
done
