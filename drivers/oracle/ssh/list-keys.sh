#!/bin/sh

ls ~/.polynimbus/ssh/id_oracle_* 2>/dev/null |grep -v \.pub$ |cut -d'_' -f3-
