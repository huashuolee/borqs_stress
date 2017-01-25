#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb devices

adb $ss shell mkdir /sdcard/logs
sleep 2
adb $ss shell touch /sdcard/ota_test_url
sleep 2
adb $ss shell touch /data/system/update4test.chaozhuo
