#!/bin/bash
c1()
{
	echo "###Video file full path in phone: e.g. /mnt/sdcard/****.mp4###"
	read mpath
	n=1
	while [ $n -le $1 ];do
		echo "`date`: Start, $n of $1"
		#adb $ss shell am start -n com.cooliris.media/.MovieView  -d "$mpath" -W
		adb $ss shell am start -n com.intel.android.gallery.media/.MovieView -d "$mpath" -W
		echo "Played."
		sleep 5
		adb $ss shell input keyevent 86
		echo "Stopped."
		sleep 1
		adb $ss shell input keyevent 4
		adb $ss shell input keyevent 4
		adb $ss shell input keyevent 4
		echo "Exited."
		sleep 1
		n=$((n+1))
	done
}

c2()
{
	echo "###Video file full path in phone: e.g. /mnt/sdcard/****.mp4###"
	read mpath
	n=1
	echo "Launch and Play..."
	while [ $n -le $1 ];do
		echo "`date`: Start, $n of $1"
		adb $ss shell am start -n com.cooliris.media/.MovieView -d "$mpath"
		sleep 1
		adb $ss shell input keyevent 90
		sleep 1
		adb $ss shell input keyevent 90
		adb $ss shell input keyevent 4
		adb $ss shell input keyevent 4
		n=$((n+1))
	done
	adb $ss shell input keyevent 86
}

usage()
{
	echo "Wrong input: $1"
	echo "Usage:`basename $0`"
	echo "-c1 [count]	Play one music for times"
	echo "-c2 [count]	Play some music then next quickly."
	echo "No option	c1 then c2"
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


	
	
	
	
	 
