#!/bin/sh

ls /etc/polynimbus/ssh/id_oracle_* 2>/dev/null |grep -v \.pub$ |sed s/\\\/etc\\\/polynimbus\\\/ssh\\\/id_oracle_//g
