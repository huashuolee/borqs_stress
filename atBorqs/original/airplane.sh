#!/bin/bash
main()
{
i=1
adb shell am start -n com.android.settings/.WirelessSettings -W
sleep 1
adb shell input keyevent 20
sleep 1

[[ -z $1 ]] && n=100 || n=$1

while [ $i -le $n ]; do
	echo "start loop #$i.."
	adb logcat -b events -c
	adb shell input keyevent 23
	sleep 1
	dur=1
	while  [ $dur -le 60 ]; do
		sleep 1
		r=`adb logcat -d -b events | grep "IDLE,DISCONNECTING"`
		r2=`adb logcat -d -b events | grep "DISCONNECTING,IDLE"`
		if [ -n "$r" -a -n "$r2" ];then
			echo "Now, airplane mode!"
			sleep 1
			break
		fi
		if [ $dur -eq 60 ];then
			echo "Not Enabled! Now catching logs"
			[[ -z "$r" ]] && echo "r!"
			[[ -z "$r2" ]] && echo "r2!"
			adb pull /data/logs/ ./
			adb pull /data/anr ./
			echo "Stop because error"
			exit 1
		fi
		dur=$((dur+1))
	done
	adb logcat -b events -c
	adb shell input keyevent 23
	sleep 1
	dur=1
	while  [ $dur -le 60 ]; do
		sleep 1
		r=`adb logcat -d -b events | grep "IDLE,INITING"`
		r2=`adb logcat -d -b events | grep "INITING,CONNECTED"`
		if [ -n "$r" -a -n "$r2"  ];then
			echo "Exited, Signal and GPRS OK!"
			sleep 1
			break
		fi
		if [ $dur -eq 60 ];then
			[[ -z "$r" ]] && echo "r!"
			[[ -z "$r2" ]] && echo "r2!"
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
mkdir airplane_"`date +%y%m%d`"
cd airplane_"`date +%y%m%d`"
main $@ 2>&1 | tee ./airplane.log
