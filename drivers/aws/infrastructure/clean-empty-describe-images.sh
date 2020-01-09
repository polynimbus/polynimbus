#!/bin/sh

find /var/cache/polynimbus/aws/describe-images -type f -empty |xargs -n 100 rm -f
