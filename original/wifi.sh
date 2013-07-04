#!/bin/bash
main()
{
echo "Loop number?"
read ltime
ltime=$((ltime*2))
n=1
adb shell input keyevent 4
adb shell input keyevent 4
adb shell am start -n com.android.settings/.wifi.WifiSettings
sleep 1
adb shell input keyevent 20
while [ $n -le $ltime ];do
	if [ $((n%2)) -eq 0 ];then
		pstate="Disabled"
		pkey=0
	else
		echo "Start!" $((n/2+1))
		pstate="Enabled"
		pkey=1
	fi
	plog="`adb shell ps | grep "system_server" | awk '{printf $2}'`"
	adb logcat -b events -c
	adb shell input keyevent 23
	dur=1
	while  [ $dur -le 60 ]; do # timer
		sleep 1
		r="`adb logcat -d -b events | grep "I/wifi_supplicant_connection_state_changed( $plog): $pkey"`" #key turnner
		if [ -n "$r"  ];then
				echo $pstate
				break
		fi
		if [ $dur -eq 60 ];then	#time out
				echo "The WiFi is not $pstate!!"
				echo "Catching logs now."
				echo $'\a';echo $'\a';echo $'\a'
				adb pull /data/logs/ ./wifi_log
				adb pull /data/anr ./wifi_log
				exit 1				
		fi
		dur=$((dur+1))
	done
	n=$((n+1))
	sleep 5
done
}

mkdir wifi_"`date +%y%m%d`"
cd wifi_"`date +%y%m%d`"
main $@ 2>&1 | tee ./wifi.log
