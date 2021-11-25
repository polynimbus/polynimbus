#!/bin/sh

grep "^\[profile " ~/.aliyuncli/credentials |sed -e 's/\[profile\ //g' -e 's/\]//g'
