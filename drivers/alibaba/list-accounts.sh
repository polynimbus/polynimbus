#!/bin/sh

grep "\[profile " /root/.aliyuncli/credentials |sed -e 's/\[profile\ //g' -e 's/\]//g'
