#!/bin/bash
main()
{
i=1
adb shell am start -n com.android.settings/.wifi.WifiApSettings
sleep 1
adb shell input keyevent 20
sleep 1

[[ -z $1 ]] && n=100 || n=$1

while [ $i -le $n ]; do
	echo "start loop #$i.."
	adb logcat -c
	adb shell input keyevent 23
	sleep 1
	dur=1
	while  [ $dur -le 60 ]; do
		sleep 1
		r=`adb logcat -d | grep "tag=\*wifi\*" | grep "releaseWakeLock"`
		if [ -n "$r"  ];then
			echo "Enabled!"
			sleep 1
			break
		fi
		if [ $dur -eq 60 ];then
			echo "Not Enabled! Now catching logs"
			adb pull /data/logs/ ./
			adb pull /data/anr ./
			echo "Stop because error"
			exit 1
		fi
		dur=$((dur+1))
	done
	adb logcat -c
	adb shell input keyevent 23
	sleep 1
	dur=1
	while  [ $dur -le 60 ]; do
		sleep 1
		r=`adb logcat -d | grep "Stopping tethering services"`
		if [ -n "$r"  ];then
			echo "Disabled!"
			sleep 1
			break
		fi
		if [ $dur -eq 60 ];then
			echo "Not Disable! Now catching logs"
			adb pull /data/logs/ ./
			adb pull /data/anr ./
			echo "Stop because error"
			exit 1
		fi
		dur=$((dur+1))
	done
	i=$((i+1))
done
}
mkdir hotsport_"`date +%y%m%d`"
cd hotsport_"`date +%y%m%d`"
main $@ 2>&1 | tee ./hotsport.log
