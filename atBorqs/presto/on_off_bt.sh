#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss shell am start -n com.android.settings/.Settings
for i in $(seq 1 100)
do 
sleep 3
adb $ss shell input tap 1054 261
sleep 2
adb $ss shell input tap 1054 261
sleep 2
echo "$i"
done

