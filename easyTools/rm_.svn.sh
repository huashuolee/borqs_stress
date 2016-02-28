#!/bin/bash

for i in `find . -name .svn`;
    do rm -r $i;
done
# find . -name |xargs rm -rf
