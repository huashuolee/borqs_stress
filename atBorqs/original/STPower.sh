#!/bin/bash
main()
{
	n=1
	while true; do
		echo "Now press power key #$n.."
		logcat -c
		sendevent /dev/input/event1 1 116 1 && sendevent /dev/input/event1 1 116 0
		echo "Pressed."
		sleep 10
		if [ "`logcat -d | grep set_screen_state`" = "" -a "`logcat -d | grep LockScreen`" = "" ];then
			echo "Power key not work, now catching logs"
			mkdir /data/local/"$now"_Powerkey
			dumpsys > /data/local/"$now"_Powerkey/dumpsys.txt &
			cp -r /data/logs/ /data/local/"$now"_Powerkey
			dmesg > /data/local/"$now"_Powerkey/dmesg.txt 
			lsmod > /data/local/"$now"_Powerkey/lsmod.txt
			echo "Over, now exit."
			exit 1
		fi
		n=$((n+1))
	done
}
now="`date +%y%m%d%H%M%S`"
mkdir /data/local/"$now"_Powerkey
main 2>&1 | busybox tee /data/local/"$now"_Powerkey/Powerkey.log
