#!/bin/sh

ls /etc/polynimbus/ssh/id_google_* 2>/dev/null |grep -v \.pub$ |grep -v \.meta$ |sed s/\\\/etc\\\/polynimbus\\\/ssh\\\/id_google_//g
