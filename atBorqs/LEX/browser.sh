#!/bin/bash
export etime=1
is3g=false
iswifi=false
usage()
{
	echo "Usage:"
	echo "`basename $0` -c CASE_ID [-s DEVICE_SERIAL_NUMBER] [-t DURATION] [-h]"
	echo "-c	1|2, 3g or Wi-Fi, MUST add."
	echo "-s	For multi devices"
	echo "-t	Duration for testing, default=60(minitues)"
	echo "-h	Show this help"
	exit
}


main()
{
	while getopts "c:s:t:h" opt;do
		case $opt in
			c) caseid=$OPTARG;;
			s) ss=$OPTARG;;
			t) ttime=$OPTARG;;
			h) usage;;
		esac
	done
	[ -z "$ttime" ] && ttime=60
	[ -n "$ss" ] && ss="-s $ss"
	case $caseid in
		1) is3g=true;;
		2) iswifi=true;;
		\?) usage;;
	esac
	browsing
	adb kill-server
}

browsing()
{
	if $is3g;then
		:
	elif $iswifi;then
		echo "Please enable Wi-Fi and connect to AP manually, press enter to continue.."
		read anyelse
	else
		usage
	fi
	adb $ss root
	sleep 3
	adb $ss remount
	sleep 3
	export ttime=$((ttime*60))
	export stime="`date +%s`"
	export dur=$((stime+ttime))
	adb $ss shell tcpdump -i any -s 0 -w /mnt/sdcard/tcp.pcap &
	n=1
	while [ $etime -le $dur ];do
		adb $ss logcat -c
		adb $ss logcat -b events -c
		echo "`date`:Loop No.$n"
		sleep 10
		adb $ss shell am start -a android.intent.action.VIEW -d http://www.baidu.com/s?wd=$n -f 0x10000000 -n com.android.browser/.BrowserActivity -W
		#adb $ss shell am start -a android.intent.action.VIEW -d http://192.168.23.202 -f 0x10000000 -n com.android.browser/.BrowserActivity -W		
		tker=1
		while true; do
			sleep 1
			if [ -n "`adb $ss shell logcat -d | grep onReceivedError`" ];then
				echo "Error happened(ReceivedError)! Now catching logs"
				echo $'\a';echo $'\a';echo $'\a'
				adb $ss pull /data/logs/ ./
				adb $ss pull /data/anr/ ./
				adb $ss pull /mnt/sdcard/tcp.pcap ./
				adb kill-server
				break
				#exit
			fi
			if [ -n "`adb $ss shell logcat -d  | grep "Displayed"`" ]; then
				echo "Page load finished.."
				sleep 5
				break
			fi
			if [ $tker -eq 60 ];then
				echo "Error happened! Now catching logs"
				echo $'\a';echo $'\a';echo $'\a'
				adb $ss pull /data/logs/ ./
				adb $ss pull /data/anr/ ./
				adb $ss pull /mnt/sdcard/tcp.pcap ./
				adb kill-server
				break				
				#exit
			fi
			tker=$((tker+1))
		done
		sleep 2
		#adb $ss shell kill -9 `adb $ss shell ps | grep browser | awk '{print $2}'`
		adb $ss shell kill  `adb $ss shell ps | grep browser | awk '{print $2}'`
		etime=`date +%s`
		wtime=$(((dur-etime)/60))
		echo "Duration $wtime mins"
		n=$((n+1))
		sleep 1
	done
}


mkdir browser_"`date +%y%m%d`"
cd browser_"`date +%y%m%d`"
main $@ 2>&1 | tee ./browser.log
