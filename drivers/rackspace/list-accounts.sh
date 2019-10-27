#!/bin/sh

grep "^\[" /root/.rack/config |sed -e 's/\[//g' -e 's/\]//g'
