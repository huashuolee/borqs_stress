#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb devices

adb $ss shell /system/bin/screenrecord /sdcard/video.mp4
