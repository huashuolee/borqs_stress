#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
for ((n=1; n<=100; n++))
do
adb $ss shell input tap 120 456
adb $ss shell input text test$n
#adb $ss shell input tap 750 450
adb $ss shell input tap 750 948
echo "$n"
sleep 2
done

