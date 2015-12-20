####
# Create by Luke.Zhang
# Mail: luke.zhang@borqs.com
####
#!/bin/bash
main()
{
	while getopts "s:n:ah" opt; do
		case $opt in
			n) count=$OPTARG;;
			s) ss=$OPTARG;;
			a) clsdcard=true;;
			h) usage;;
			*) usage;;
			\?) usage;;
		esac
	done
	[[ -z $clsdcard ]] && clsdcard=false
	[[ -z $count ]] && count=100
	[[ -n "$ss" ]] && ss="-s $ss"
	model="`adb $ss shell getprop ro.product.model | tr -cd [A-Za-z0-9]`"
	if [ "$model" != "X900" -o "$model" != "BKBGB"  ];then
		adb $ss remount > /dev/null
		adb $ss shell "rm -r /system/app/Lockscreen*" > /dev/null
	fi
	n=1
	while [ $n -le $count ];do
		echo "`date +%X`: Looping $n of $count"
		doclear
		wboot
		n=$((n+1))
	done
}


move()
{
	adb $ss shell input motionevent $1 $2 down
	adb $ss shell input motionevent $1 $2 up
}

logger()
{
	mkdir -p ../masterclear_"$sddate"/"$shtime"/$n/logs
	adb $ss pull /data/logs/ ./masterclear_"$sddate"/"$shtime"/$n/logs
	adb $ss pull /data/anr/ ./masterclear_"$sddate"/"$shtime"/$n/logs
	adb $ss pull /data/system/dropbox/ ./masterclear_"$sddate"/"$shtime"/$n/logs
}

usage()
{
	echo "`basename $0`: [-n count] [-a] [-h]"
	echo "-n	The number of loop, defult=100."
	echo "-a	Master clear include clear SD card."
	echo "-h	Show this help."
	exit 0
}

doclear()
{
	echo "`date +%X`: Start doing master clear.."
	adb $ss shell am start -n com.android.settings/.MasterClear
	sleep 2
	if $clsdcard;then
		echo "`date +%X`: Clear SD card enabled"
		move 45 510 #enable clear SD card.
		sleep 2
	fi
	move 300 970 #Clear phone
	sleep 2
	move 300 300 #Comfirm clear
	move 300 260
	sleep 2
	if [ $n -ne 1 -a "$model" = "X900" -o "$model" = "BKBGB"  ];then
		njob="`jobs | tail -n 1 | awk '{print $1}' | tr -cd "[0-9]"`"
		kill -9 %"$jobs" >/dev/null
	fi
	dur=1
	echo "`date +%X`: Will power off..."
	while true;do
		key="`adb devices | grep $ss`"
		echo "Not yet.."
		sleep 1
		if [ -n "$key" ];then
			echo "`date +%X`: Already powered off."
			break
		fi
		if [ $dur -eq 60 ];then
			echo "`date +%X`: Error! When power off."
			break
			loger
			exit 1
		fi
		dur=$((dur+1))
	done		
}

sinikami()
{
	while true;do
		nprocess="`adb $ss shell ps | grep "com.xolo.customercare" | awk '{print $2}'`"
		[[ -n "$nprocess" ]] && adb $ss shell kill -9 $nprocess
		sleep 1
	done
}


wboot()
{
	echo "`date +%X`: Waiting for device.."
	dur=1
	while true;do
		rpower="`adb $ss shell logcat -d | grep -i "bootCompleted"`"
		echo "Not yet.."
		sleep 1
		if [ -n "$rpower" ]; then
			echo "`date +%X`: Launcher should be showed."
			break
		fi
		if [ $dur -eq 120 ];then
			echo "`date +%X`: Phone did not power up!"
			logger
			exit 1
		fi
		dur=$((dur+1))
	done
	sleep 1
	echo "`date +%X`: Unlocking screen"
	if [ "$model" = "X900" -o "$model" = "BKBGB" ];then
		sinikami &
	fi
	adb $ss shell input motionevent 100 800 down
	adb $ss shell input motionevent 580 800 move
	adb $ss shell input motionevent 580 800 up
	sleep 1
	adb $ss shell input keyevent 3
	adb $ss shell input keyevent 3
	sleep 2
	
}


shdate="`date +%y%m%d`"
shtime="`date +%H%S`"

mkdir -p ./masterclear_"$shdate"/"$shtime"
main $@ 2>&1 | tee ./masterclear_"$shdate"/"$shtime"/masterclear_sh.log

