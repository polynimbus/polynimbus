#!/bin/sh

grep "^\[" /root/.aws/credentials |sed -e 's/\[//g' -e 's/\]//g'
