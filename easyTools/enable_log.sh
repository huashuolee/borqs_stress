#!/bin/bash

adb shell mkdir /sdcard/chaozhuo_log

adb shell  'logcat -v time -r 5000 -n 20 -f /sdcard/chaozhuo_log/ap.log & '
