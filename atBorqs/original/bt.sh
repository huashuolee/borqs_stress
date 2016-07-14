#!/bin/bash
main()
{
i=1
adb shell am start -n com.android.settings/.bluetooth.BluetoothSettings -a android.intent.action.MAIN -W
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
		r=`adb logcat -d -b events | grep "I/am_create_service" | grep "com.android.bluetooth/.opp.BluetoothOppService"`
		r2=`adb logcat -d -b events | grep "I/am_create_service" | grep "com.android.bluetooth/.pbap.BluetoothPbapService"`
		if [ -n "$r" -a -n "$r2" ];then
			echo "Enabled"
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
		r=`adb logcat -d -b events | grep "I/am_destroy_service" | grep "com.android.bluetooth/.opp.BluetoothOppService"`
		r2=`adb logcat -d -b events | grep "I/am_destroy_service" | grep "com.android.bluetooth/.pbap.BluetoothPbapService"`
		if [ -n "$r" -a -n "$r2"  ];then
			echo "Disabled"
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
mkdir bt_"`date +%y%m%d`"
cd bt_"`date +%y%m%d`"
main $@ 2>&1 | tee ./bt.log
