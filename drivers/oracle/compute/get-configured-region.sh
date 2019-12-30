#!/bin/sh

grep ^region= /root/.oci/config |cut -d= -f2
