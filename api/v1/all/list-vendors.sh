#!/bin/sh

if [ "$1" = "" ]; then
	ls /opt/polynimbus/drivers
else
	subsystem=$1
	for driver in `ls /opt/polynimbus/drivers`; do
		if [ -d /opt/polynimbus/drivers/$driver/$subsystem ]; then
			echo $driver
		fi
	done
fi
