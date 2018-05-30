#!/bin/bash
main()
{
echo "Please input loop times:"
read lt
echo "Input devices number"
read dev
n=1
while [ $n -le $lt ];do
	echo "`date`: Start loop $n of $lt"
	echo "Launch video camera."
	adb -s $dev logcat -c
	adb -s $dev shell am start -a android.intent.action.MAIN -n com.android.camera/.VideoCamera -f 0x10200000 -W
	dur=1
	while true;do
		if [ -n "`adb -s $dev logcat -d | grep "after open camera !!!"`" ];then
			sleep 1
			echo "Camera launched!"
			break
		fi
		if [ $dur -eq 30 ];then
			sleep 1
			echo "Camera launch failed!"
			adb -s $dev pull /data/logs ./video_$dev
			adb -s $dev pull /data/anr ./video_$dev
			adb -s $dev pull /data/system/dropbox ./video_$dev
			exit 1
		fi
		dur=$((dur+1))
	done
	sleep 1	
	echo "Start recording."
	adb -s $dev shell input keyevent 27
	while true;do
		if [ -n "`adb -s $dev logcat -d | grep "startVideoRecording"`" ];then
			sleep 1
			echo "Recording!"
			break
		fi
		if [ $dur -eq 30 ];then
			echo "Recording failed!"
			adb -s $dev pull /data/logs ./video_$dev
			adb -s $dev pull /data/anr ./video_$dev
			adb -s $dev pull /data/system/dropbox ./video_$dev
			exit 1
		fi
		dur=$((dur+1))
	done	
	sleep 5
	echo "End recording."
	adb -s $dev shell input keyevent 27
	while true;do
		if [ -n "`adb -s $dev logcat -d | grep "stopVideoRecording"`" ];then
			sleep 1
			echo "Stopped!"
			break
		fi
		if [ $dur -eq 30 ];then
			echo "Stopped failed!"
			adb -s $dev pull /data/logs ./video_$dev
			adb -s $dev pull /data/anr ./video_$dev
			adb -s $dev pull /data/system/dropbox ./video_$dev
			exit 1
		fi
		dur=$((dur+1))
	done
	sleep 1
	echo "Exit camera."
	adb -s $dev shell input keyevent 4
	while true;do
		if [ -n "`adb -s $dev logcat -d | grep "closeCamera"`" ];then
			sleep 1
			echo "Exited!"
			break
		fi
		if [ $dur -eq 30 ];then
			echo "Exit failed!"
			adb -s $dev pull /data/logs ./video_$dev
			adb -s $dev pull /data/anr ./video_$dev
			adb -s $dev pull /data/system/dropbox ./video_$dev
			exit 1
		fi
		dur=$((dur+1))
	done
	n=$((n+1))
	sleep 1
	echo " "
done
echo "Tetst overed."
}

main 2>&1 | tee ./camera.txt
