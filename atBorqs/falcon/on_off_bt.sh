#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
for i in $(seq 1 100)
do 
adb $ss shell am start -n com.android.settings/.Settings
sleep 3
adb $ss shell input tap 100 234
sleep 2
adb $ss shell input tap 200 234
sleep 5
adb $ss shell input tap 200 234
sleep 5
adb $ss shell input keyevent 4
sleep 2
echo "$i"
done

