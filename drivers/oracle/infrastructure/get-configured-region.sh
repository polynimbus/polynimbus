#!/bin/sh

grep ^region= ~/.oci/config |cut -d= -f2
