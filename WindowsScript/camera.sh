#!/bin/bash
shtime="`date +%y%m%d%H%M%S`"
mkdir -p ./"$shtime"_Camera
cd ./"$shtime"_Camera
	#Intent { act="$ctype".intent.action.MAIN cat=["$ctype".intent.category.LAUNCHER] flg=0x10200000 cmp=com."$ctype".camera/.Camera } from pid 1717
#adb $ss shell <<EOF
#echo "`date`: <string name="pref_camera_id_key">0</string>" >> /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml
#exit
#EOF



back()
{
	tcamera="`adb $ss shell cat /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml | grep "pref_camera_id_key" | awk -F'pref_camera_id_key">' {'print $2'} | awk -F'</' {'print $1'}`"
	if [ "$tcamera" = "1" ];then
		echo "`date`: Switch Camera 1->0, will launch back camera"
adb $ss shell <<EOF
sed -i 's/>1</>0</' /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml >/dev/nul
exit >/dev/nul
EOF
	else
		echo "`date`: Already back camera."
	fi
	whichcamera="Back Camera"
	capture
	
}

front()
{
	tcamera="`adb $ss shell cat /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml | grep "pref_camera_id_key" | awk -F'pref_camera_id_key">' {'print $2'} | awk -F'</' {'print $1'}`"
	if [ "$tcamera" = "0" ];then
	echo "`date`: Switch Camera 0->1, will launch front camera"
adb $ss shell <<EOF1
sed -i 's/>0</>1</' /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml >/dev/nul
exit >/dev/nul
EOF1
	else
		echo "`date`: Already front camera"
	fi
	whichcamera="Front Camera"
	capture
}






capture()
{
	i=1
	while [ $i -le $num ];do
################################################################3
		if $exited || [ $i -eq 1 ];then
			echo "`date`: Launch Camera... $i of $num, $whichcamera."
			adb $ss logcat -c
			adb $ss shell am start -a "$ctype".intent.action.MAIN -c "$ctype".intent.category.LAUNCHER -f 0x10200000 -n com."$ctype".camera/.Camera -W
			dur=1
			while true;do
				sleep 1
				if [ -n "`adb $ss logcat -d | grep "com."$ctype".camera/.Camera"`" ];then
					sleep 1
					echo "`date`: Camera launched!"
					break
				fi
				if [ $dur -eq 30 ];then
					echo "`date`: Camera launch failed!"
					adb $ss pull /data/logs/ ./
					adb $ss pull /data/anr ./
					adb $ss pull /data/system/dropbox ./
					exit 1
				fi
				dur=$((dur+1))
			done
		fi
##############################################################3
		echo "`date`: Looping... $i of $num, $whichcamera."			
		dur=1
		adb $ss logcat -c
		adb $ss shell input keyevent $ckey
		while true;do
			sleep 1
			if [ -n "`adb $ss logcat -d | grep "mJpegCallbackFinishTime"`" ];then
				sleep 1
				echo "`date`: Captured!"
				break
			fi
			if [ $dur -eq 30 ];then
				echo "`date`: Capture failed!"
				adb $ss pull /data/logs/ ./
				adb $ss pull /data/anr ./
				adb $ss pull /data/system/dropbox ./
				exit 1
			fi
			dur=$((dur+1))
		done
#######################################################################
		sleep 1
		if $exited || [ $i -eq $num ];then
			dur=1
			while true;do
				sleep 1
				adb $ss shell input keyevent 4
				if [ -n "`adb $ss logcat -b events -d | grep "am_destroy_activity"`" ];then
					sleep 1
					echo "`date`: Exit camera.."
					break
				fi
				if [ $dur -eq 30 ];then
					echo "`date`: Exit failed."
					adb $ss pull /data/logs/ ./
					adb $ss pull /data/anr ./
					adb $ss pull /data/system/dropbox ./
					exit 1
				fi
				dur=$((dur+1))
			done
		fi
######################################################
		i=$((i+1))
	adb $ss logcat -b events -c
	adb $ss logcat -c
	#############################################################
	if $switch;then
		tcamera="`adb $ss shell cat /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml | grep "pref_camera_id_key" | awk -F'pref_camera_id_key">' {'print $2'} | awk -F'</' {'print $1'}`"
		echo $tcamera
		if [ "$tcamera" = "1" ];then
			echo "`date`: Switch Camera 1->0, will launch back camera"
adb $ss shell <<EOF
sed -i 's/>1</>0</' /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml >/dev/nul
exit >/dev/nul
EOF
			whichcamera="Back Camera"
		else
			echo "`date`: Switch Camera 0->1, will launch front camera"
adb $ss shell <<EOF1
sed -i 's/>0</>1</' /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml >/dev/nul
exit >/dev/nul
EOF1
			whichcamera="Front Camera"
		fi
	fi
	done
############################################################################
	echo "`date`: Test Over~"
	
}
main()
{
	while getopts "fbsn:het:m:" opt;do
		case $opt in
			f) front=true;;
			b) back=true;;
			s) switch=true;;
			n) num=$OPTARG;;
			e) exited=true;;
			t) ctype=$OPTARG;;
			m) ss="$OPTARG";;
			h) usage;;
			*) usage;;
			\?) usage;;
		esac

	done
	[[ -n $ss ]] && ss="-s $ss"
	[[ -z $front ]] && front=false
	[[ -z $back ]]  && back=false
	[[ -z $switch ]] && switch=false
	[[ -z $num ]] && num=100
	[[ -z $exited ]] && exited=false
	$switch && exited=true
	[ -z "$ctype" ] && usage
	if [ $ctype -eq 1 ];then
		ctype="android"
		ckey=23
	elif [ $ctype -eq 0 ];then
		ctype="intel"
		ckey=27
	else
		echo "`date`: Camera type error!"
		usage
	fi
	adb $ss root
	sleep 2
	adb $ss remount
	sleep 2
	


	tcamera="`adb $ss shell cat /data/data/com."$ctype".camera/shared_prefs/com."$ctype".camera_preferences.xml | grep "pref_camera_id_key" | awk -F'pref_camera_id_key">' {'print $2'} | awk -F'</' {'print $1'}`"
	if [ "$tcamera" != "0" -a "$tcamera" != "1" ];then
		echo "`date`: Please setup camera manually, launch & switch camera once and exit."
		exit 0
	fi
	if $back && $front; then
		back
		adb $ss shell input keyevent 4
		front
	elif $back; then
		back
	elif $front; then
		front
	elif $switch; then
		num=$((num*2))
		back
	else
		usage
	fi
}

usage()
{
	echo "`basename $0` -t [1|0] -f -b -s -e -n [count]"
	echo "-f	Front camera"
	echo "-b	Back camera"
	echo "-e	Exit camera after each capture."
	echo "-n	Number of loop, empty=100"
	echo "-t	1|0, android or intel"
	echo "-s	Capture picture with swith back/front camera, will include \"-e\" with adding this option."
	echo "-m	For multi devices."
	echo "-h	Show this help"
	exit 0
}



main $@ 2>&1 | tee ./camera.txt
cd ..
