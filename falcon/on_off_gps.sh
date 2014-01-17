#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
for i in $(seq 1 100)
do 
adb $ss shell input tap 412 200
sleep 2
adb $ss shell input tap 400 640
sleep 2
adb $ss shell input 412 200
sleep 2
echo "$i"
done
