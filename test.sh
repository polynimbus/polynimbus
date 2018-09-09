#!/bin/sh

find -type f |grep php$ |xargs -n 1 php -l
