#!/bin/sh

cat /root/.oci/config |grep ^key_file= |cut -d= -f2 |sed s/key.pem/key_public.pem/g
