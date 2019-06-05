#!/bin/bash
dirname=`date +%Y%m%d_%H-%M-%S`_logs
mkdir $dirname
adb root
adb remount

#adb pull -a /data/logs/ ./logs
#adb pull -a /data/logs/panic/ ./logs
#adb shell dumpstate > ./logs/dumpstate.txt

adb pull -a /data/anr/ ./$dirname
adb pull -a /data/system/dropbox/ ./$dirname
7z a -t7z $dirname.7z $dirname
