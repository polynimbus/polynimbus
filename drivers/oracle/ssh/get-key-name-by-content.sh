#!/bin/sh

content=$1
basename `grep -l $content ~/.polynimbus/ssh/id_oracle_*.pub` .pub |sed s/id_oracle_//g
