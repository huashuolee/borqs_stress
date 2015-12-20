#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
while true;
do
result = "`adb $ss logcat |grep "success"`" 
if [ -n "$result"  ];then
sleep 1
adb $ss shell input tap 731 525
fi
done
