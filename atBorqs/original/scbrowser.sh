#!/bin/bash
export adb="adb shell"
export etime=1
main()
{	
	adb shell tcpdump -i any > ./tcp.log &
	echo "Time of browser?(minute)"
	read rtime
	export rtime=$((rtime*60))
	echo "Please manually enable WiFi, Press a key to continue..."
	read anyelse
	n=1
	npage=1
	export stime=`date +%s`
	export dur=$((stime+rtime))
	while [ $etime -le $dur ];do
		if [ $npage -eq 1 ];then
			page="http://espn.go.com/"
			npage=$((npage+1))
		elif [ $npage -eq 2 ];then
			page="http://www.cnn.com/"
			npage=$((npage+1))
		elif [ $npage -eq 3 ];then
			page="http://www.youtube.com/"
			npage=$((npage+1))
		elif [ $npage -eq 4 ];then
			page="http://www.globaltimes.cn/"
			npage=1
		fi
		adb logcat -c
		adb logcat -b events -c
		echo "`date`:Loop No.$n"
		$adb am start -a android.intent.action.VIEW -d $page -f 0x10000000 -n com.android.browser/.BrowserActivity -W
		tker=1
		while true; do
			sleep 1
			if [ -n "`adb logcat -d | grep onReceivedError`" ];then
				echo "Error happened(ReceivedError)! Now catching logs"
				echo $'\a';echo $'\a';echo $'\a'
				adb pull /data/logs/ ./
				adb pull /data/anr ./
				adb shell busybox ifconfig -a > ./ifconfig.txt
				adb shell busybox route -n > ./route.txt
				adb shell lsmod > ./lsmod.txt
				adb shell cat /proc/mounts > ./mount.txt
				adb shell dumpstate > ./dumpsys.txt
				exit 1
			fi
			if [ -n "`adb logcat -d -b events | grep "I/browser_page_loaded"`" ]; then
				echo "Page load finished.."
				break
			fi
			if [ $tker -eq 80 ];then
				echo "Error happened! Now catching logs"
				echo $'\a';echo $'\a';echo $'\a'
				adb pull /data/logs/ ./
				adb pull /data/anr ./
				adb shell busybox ifconfig -a > ./ifconfig.txt
				adb shell busybox route -n > ./route.txt
				adb shell lsmod > ./lsmod.txt
				adb shell cat /proc/mounts > ./mount.txt
				adb shell dumpstate > ./dumpsys.txt
				exit 1
			fi
			tker=$((tker+1))
		done
		sleep 2
		$adb kill -9 `$adb ps | grep browser | awk '{print $2}'`
		etime=`date +%s`
		n=$((n+1))
		sleep 1
	done
	kill -9 %1
	kill -9 %2
	echo "WiFi overed."
kill -9 %1
kill -9 %2
}
mkdir browser_"`date +%y%m%d`"
cd browser_"`date +%y%m%d`"
main $@ 2>&1 | tee ./browser.log
