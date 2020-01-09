#!/bin/sh

grep ^tenancy= /root/.oci/config |cut -d= -f2
