#!/bin/bash
adb devices

ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss shell am broadcast -a android.intent.action.MEDIA_MOUNTED -d file:///mnt/sdcard/
