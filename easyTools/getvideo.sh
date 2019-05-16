#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb devices

adb $ss pull /sdcard/video.mp4 ./`date +%Y%m%d_%H-%M-%S`.mp4
