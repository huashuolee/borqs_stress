#!/bin/bash
c1()
{
	adb $ss shell ls /mnt/sdcard/*/*.mp3
	adb $ss shell ls /mnt/sdcard/*.mp3
	echo ""
	echo "###Music file full path in phone: e.g. /mnt/sdcard/****.mp3###"
	read mpath
	n=1
	while [ $n -le $1 ];do
		echo "`date`: Start, $n of $1"
		adb $ss shell am start -n com.android.music/.MediaPlaybackActivity -d "$mpath" -W
		echo "Played."
		sleep 5
		adb $ss shell input keyevent 86
		echo "Stopped."
		sleep 1
		adb $ss shell input keyevent 4
		echo "Exited."
		sleep 1
		n=$((n+1))
	done
}

c2()
{
	n=1
	adb $ss shell am start -n com.android.music/.TrackBrowserActivity -a android.intent.action.PICK -t vnd.android.cursor.dir/track
	adb $ss shell input keyevent 20
	adb $ss shell input keyevent 23
	echo "Launch and Play..."
	while [ $n -le $1 ];do
		echo "`date`: Start, $n of $1"
		sleep 2
		adb $ss shell input keyevent 87

		n=$((n+1))
	done
	adb $ss shell input keyevent 86
}

usage()
{
	echo "Usage:`basename $0`"
	echo "-c 1	Play one music for times"
	echo "-c 2 	Play some music then next quickly."
	echo "-n [COUNT] Loop number"
	echo "-s [DEVICE_SERIAL_NUMBER]"
	exit 0
}

while getopts "c:n:s:h" opt;do
	case $opt in
		c) caseid=$OPTARG;;
		n) count=$OPTARG;;
		s) ss=$OPTARG;;
		h) usage;;
	esac
done
[ -z "$count" ] && count=100
[ -n "$ss" ] && ss="-s $ss"
case $caseid in
	1) c1 $count;;
	2) c2 $count;;
	\?) usage;;
esac


	
	
	
	
	 
