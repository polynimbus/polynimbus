#!/bin/sh

cat /root/.oci/config |grep ^region= |cut -d= -f2
