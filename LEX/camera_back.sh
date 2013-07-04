#!/bin/bash

main()
{
	echo "Please input capture times:"
	read num
	echo "Input device number"
	read dev	
	i=1
	while [ $i -le $num ];do
		echo "Camera Capture... $i of $num, camera."
		#adb logcat -c
		adb -s $dev shell am start -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -f 0x10200000 -n com.intel.camera/.Camera -W
		#dur=1
		#while true;do
		#	sleep 1
		#	if [ -n "`adb logcat -d | grep "com.android.camera/.Camera"`" ];then
		#		sleep 1
		#		echo "Camera launched!"
		#		break
		#	fi
		#	if [ $dur -eq 30 ];then
		#		echo "Camera launch failed!"
		#		adb pull /data/logs ./
		#		adb pull /data/anr ./
		#		adb pull /data/system/dropbox ./
		#		exit 1
		#	fi
		#	dur=$((dur+1))
		#done
		#	sleep 2
			adb -s $dev shell input keyevent 27
			adb -s $dev shell input keyevent 23
			
		dur=1
		while [ $dur -le 60 ];do
			sleep 0
			if [ -n "`adb -s $dev logcat -d | grep "GDC is disabled now"`" ];then
				sleep 1
				echo "Captured!"
				break
			fi
			if [ $dur -eq 60 ];then
				echo "Capture failed!"
				adb -s $dev pull /data/logs/ ./Camera_$dev
				adb -s $dev pull /data/anr/ ./Camera_$dev
				adb -s $dev pull /data/system/dropbox ./Camera_$dev
				exit 1
			fi
			dur=$((dur+1))
		done
		dur=1
		
		while [ $dur -le 50 ];do
			sleep 0
			if [ -n "`adb -s $dev logcat -d | grep "Start normal preview"`" ];then
				sleep 1
				echo "On preview mode"
				break
			fi
			if [ $dur -eq 50 ];then
				echo "Preview mode failed."
				adb -s $dev pull /data/logs/ ./Camera_$dev
				adb -s $dev pull /data/anr/ ./Camera_$dev
				adb -s $dev pull /data/system/dropbox ./Camera_$dev
				exit 1
			fi
			dur=$((dur+1))
		done
		sleep 0
		#dur=1
		#while true;do
		#	sleep 1
		#	adb shell input keyevent 4
		#	if [ -n "`adb logcat -b events -d | grep "am_destroy_activity"`" ];then
		#		sleep 2
		#		echo "Exit camera.."
		#		break
		#	fi
		#	if [ $dur -eq 30 ];then
		#		echo "Exit failed."
		#		adb pull /data/logs ./
		#		adb pull /data/anr ./
		#		adb pull /data/system/dropbox ./
		#		exit 1
		#	fi
		#	dur=$((dur+1))
		#done
		i=$((i+1))
		
	done
}
main 2>&1 | tee ./camera.txt
cd ..
