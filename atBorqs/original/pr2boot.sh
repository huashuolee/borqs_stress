#!/bin/bash

while true;do
	if [ "`adb devices | awk 'NR==2 {print $1}'`" != "" ];then
		echo "Devices found!"
		break
	fi
	echo "Device not find yet..."
	sleep 10
done
while true;do
	if [ "`adb shell input keyevent 82`" = "" ];then
		adb shell input keyevent 82
		sleep 1
		adb shell input keyevent 82
		echo "Unlocked"
		break
	fi
done
./launchVNC.sh fastdroid-vnc > /dev/null

