#!/bin/sh

content=$1
basename `grep -l $content /etc/polynimbus/ssh/id_oracle_*.pub` .pub |sed s/id_oracle_//g
