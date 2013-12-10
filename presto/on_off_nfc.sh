#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
#adb $ss shell am start -n com.android.settings/.Settings
sleep 3
for i in $(seq 1 100)
do 
adb $ss shell input tap 335 436
sleep 5
adb $ss shell input tap 335 436
sleep 5
echo "$i"
done

