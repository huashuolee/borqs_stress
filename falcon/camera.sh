#!/bin/bash

ss=""
[[ -n $1 ]] && ss="-s $1"

for (( n=1; n<=1000; n++ ))
do
   adb $ss shell input keyevent 27   
   sleep 2
   echo $n
done
echo "done"

