#!/bin/sh

ls ~/.polynimbus/ssh/id_google_* 2>/dev/null |grep -v \.pub$ |grep -v \.meta$ |cut -d'_' -f3-
