#!/bin/bash
main()
{
case $1 in 
	1) ctype="android";ckey=23;
		;;
	0) ctype="intel";ckey=27;
		;;
	*) echo "error!" && exit;;
esac
[ -n "$2" ] && ss="-s $2"
[ -z "$@" ] && echo "Usage:`basename $0`: 1|0 [DEVICE_SERIAL_NUMBER]"

adb $ss logcat -c
echo "Please input loop times:"
read lt
n=1
while [ $n -le $lt ];do
	echo "`date`: Start loop $n of $lt"
	echo "Launch video camera."
	#adb $ss shell am start -n com.intel.camera/.VideoCamera -f 0x6000000
	adb $ss shell am start -n com."$ctype".camera/.VideoCamera -f 0x6000000
	dur=1
	while true;do
		if [ -n "`adb $ss logcat -d | grep -i "Displayed"`" ];then
			sleep 1
			echo "Camera launched!"
			break
		fi
		if [ $dur -eq 30 ];then
			echo "Camera launch failed!"
			adb pull /data/logs/ ./
			adb pull /data/anr ./
			adb pull /data/system/dropbox ./
			exit 1
		fi
		dur=$((dur+1))
		sleep 1
	done
	sleep 1	
	echo "Start recording."
	adb $ss shell input keyevent $ckey
	while true;do
		if [ -n "`adb $ss logcat -d | grep "initializeRecorder"`" ];then
			sleep 1
			echo "Recording!"
			break
		fi
		if [ $dur -eq 30 ];then
			echo "Recording failed!"
			adb pull /data/logs/ ./
			adb pull /data/anr ./
			adb pull /data/system/dropbox ./
			exit 1
		fi
		sleep 1
		dur=$((dur+1))
	done	
	sleep 5
	echo "End recording."
	adb $ss shell input keyevent $ckey
	while true;do
		if [ -n "`adb $ss logcat -d | grep "stopVideoRecording"`" ];then
			sleep 1
			echo "Stopped!"
			break
		fi
		if [ $dur -eq 30 ];then
			echo "Stopped failed!"
			adb pull /data/logs/ ./
			adb pull /data/anr ./
			adb pull /data/system/dropbox ./
			exit 1
		fi
		dur=$((dur+1))
	done
	sleep 1
	echo "Exit camera."
	adb $ss shell input keyevent 4
	while true;do
		if [ -n "`adb $ss logcat -d | grep "closeCamera"`" ];then
			sleep 1
			echo "Exited!"
			break
		fi
		if [ $dur -eq 30 ];then
			echo "Exit failed!"
			adb pull /data/logs/ ./
			adb pull /data/anr ./
			adb pull /data/system/dropbox ./
			exit 1
		fi
		sleep 1
		dur=$((dur+1))
	done
	n=$((n+1))
	sleep 1
	echo " "
	adb $ss logcat -c
done
echo "Tetst overed."
}
shtime="`date +%y%m%d%H%M%S`"
mkdir -p ./"$shtime"_VCamera
cd ./"$shtime"_VCamera
main $@ 2>&1 | tee ./camera.txt
