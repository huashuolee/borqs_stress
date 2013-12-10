#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
for (( n=1; n<=1000; n++ ))
do
   adb $ss "wait-for-device" reboot
   sleep 30
   echo $n
done
echo "done"

