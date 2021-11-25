#!/bin/sh

grep "^\[" ~/.rack/config |sed -e 's/\[//g' -e 's/\]//g'
