#!/bin/sh

install_pip() {
	pkg=$1
	echo "checking for pip package $pkg"
	if [ "`pip list |grep $pkg`" = "" ]; then
		pip install $pkg
	else
		pip install --upgrade $pkg
	fi
}


if [ "$1" = "" ]; then
	echo "usage: $0 <package> [package] [...]"
	exit
fi

for package in $@; do
	install_pip $package
done
