#!/bin/sh

cat /root/.oci/config |grep ^tenancy= |cut -d= -f2
