#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
for ((n=1; n<=100; n++))
do
adb $ss shell input tap 670 68
sleep 1
adb $ss shell input tap 300 201
sleep 1
adb $ss shell input text test$n
sleep 1
adb $ss shell input tap 300 259
sleep 1
adb $ss shell input text test$n
sleep 1
adb $ss shell input tap 762 76
echo "$n"
sleep 1
done

