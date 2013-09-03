#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"

for (( n=1; n<=100; n++ ))
do
    adb $ss shell input tap 30 896
    sleep 1
    adb $ss shell input tap 380 360 
    sleep 1
    adb $ss shell input text test$n
    sleep 3
    adb $ss shell input tap 640 80
    sleep 10
    echo $n
done
echo "done"

