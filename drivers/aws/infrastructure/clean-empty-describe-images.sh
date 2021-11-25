#!/bin/sh

find ~/.polynimbus/cache/aws/describe-images -type f -empty |xargs -n 100 rm -f
