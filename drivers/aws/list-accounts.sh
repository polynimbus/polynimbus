#!/bin/sh

grep "^\[" ~/.aws/credentials |sed -e 's/\[//g' -e 's/\]//g'
