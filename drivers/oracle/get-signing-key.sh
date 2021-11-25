#!/bin/sh

grep ^key_file= ~/.oci/config |cut -d= -f2 |sed s/key.pem/key_public.pem/g
