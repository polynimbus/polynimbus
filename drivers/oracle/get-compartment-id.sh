#!/bin/sh

grep ^tenancy= ~/.oci/config |cut -d= -f2
