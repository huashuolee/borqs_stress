#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb devices

adb $ss shell /system/bin/screencap -p /sdcard/screenshot.png
sleep 2
adb $ss pull /sdcard/screenshot.png ./`date +%Y%m%d_%H-%M-%S`.png
