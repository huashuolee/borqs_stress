#!/bin/bash

for i in `find . -name .svn`;
    do rm -r $i;
done
