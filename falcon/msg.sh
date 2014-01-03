#!/bin/bash
move()
{
	adb -s $sa shell input tap $1 $2 
	
}



mms()
{
	echo "`date`: Empty your Msg box first, any key to continue."
	read anyelse
	n=1
	adb -s $sa "wait-for-devices" root
	adb -s $sb "wait-for-devices" root
	adb -s $sa "wait-for-devices" remount
	adb -s $sb "wait-for-devices" remount
	adb -s $sa "wait-for-devices"
	adb -s $sb "wait-for-devices"
	sleep 5
	while [ $n -le $tn ];do
		doom=0
		echo "`date`:Start to send MMS to $num"
		echo "`date`:Looping *****************************************************No.$n"
		adb -s $sa shell am start -a android.intent.action.SENDTO -d sms:$num -n com.android.mms/.ui.ComposeMessageActivity -W
		sleep 2
		adb -s $sa shell input text testABC$n
		sleep 2
		#add attachments(audio).
		move 500 65
		sleep 2
		move 350 600			
		sleep 2
                move 350 200
                sleep 2
		move 350 900
		sleep 2
                move 468 928
		
		
	#	only subject	 
	#	move 160 355
	#			
	#
	#	adb -s $sa shell input text testABC$n	 
	#	sleep 3
	#	move 197 247 		
		adb -s $sb shell logcat -b events -c
		
		sleep 2
		adb -s $sa shell input keyevent 4
		adb -s $sa shell input keyevent 4
		adb -s $sa shell input keyevent 4
		adb -s $sa shell input keyevent 4		
		dur=1
		echo "wait incoming MMS………………………………………………………………………………………………………………………………………………………………"
		while  [ $dur -le 900 ]; do
			sleep 1
			r="`adb -s $sb shell logcat -d -b events | grep "com.android.mms" | grep "Notification"`"
			if [ -n "$r"  ];then
				echo "`date`: MMS recieved!"
				result "m1"
				sleep 5
				break
			fi
			if [ $dur -eq 900 ];then
				echo "`date`: MMS not recieved! Now catching logs"
				loger
				result "m0"
				doom=1
				break
			fi
			dur=$((dur+1))
		done
		[ $doom -eq 1 ] && n=$((n+1)) && continue
		n=$((n+1))		
	done
}


loger()
{
	adb -s $sa pull /logs/ ./"$n"_logs/A/
	adb -s $sa pull /data/anr/ ./"$n"_logs/A/
	adb -s $sa pull /sdcard/iplogs/ ./"$n"_logs/A/
	adb -s $sa pull /sdcard/logs/ ./"$n"_logs/A/
	adb -s $sb pull /sdcard/logs/ ./"$n"_logs/B/
	adb -s $sb pull /sdcard/iplogs/ ./"$n"_logs/B/
	adb -s $sb pull /logs/ ./"$n"_logs/B/
	adb -s $sb pull /data/anr/ ./"$n"_logs/B/
	adb -s $sa pull /data/system/dropbox/ ./"$n"_logs/A/
	adb -s $sb pull /data/system/dropbox/ ./"$n"_logs/B/
	adb -s $sa pull /data/usb_dmesg.txt ./"$n"_logs/A/
	adb -s $sb pull /data/usb_dmesg.txt ./"$n"_logs/B/
	adb -s $sa shell dumpstate > ./"$n"_logs/A/dumpstate.txt
	adb -s $sb shell dumpstate > ./"$n"_logs/B/dumpstate.txt
	sleep 10
}

timeout()
{
	dur=1
	while  [ $dur -le 60 ]; do
	sleep 1
	r=`adb -s $sb logcat -d -b radio -v time | grep Received`
	if [ -n "$r"  ];then
		echo "Msg recieved!"
		sleep 5
		break
	fi
	if [ $dur -eq 60 ];then
		echo "Msg not recieved! Now catching logs"

		exit 1
	fi
	dur=$((dur+1))
	done

}


sms()
{
	adb -s $sa "wait-for-devices" root
	adb -s $sb "wait-for-devices" root
	adb -s $sa "wait-for-devices" remount
	adb -s $sb "wait-for-devices" remount
	adb -s $sa "wait-for-devices"
	adb -s $sb "wait-for-devices"
	n=1
	while [ $n -le $tn ]; do
		sleep 5
		doom=0
		echo "`date`: `date`: Start to send SMS to $num"
		echo "`date`: Looping ***********************************************************************No.$n"
		adb -s $sa shell am start -a android.intent.action.SENDTO -d sms:$num -n com.android.mms/.ui.ComposeMessageActivity -W
		sleep 1
		adb -s $sa shell input text testABC$n
		sleep 1
		move 468 928
		sleep 2
		#move 230 340
		#adb -s $sa shell input keyevent 22
		#sleep 2
		#adb -s $sa shell input keyevent 66
		#sleep 2
		#adb -s $sa shell input keyevent 22
		#sleep 2
		#adb -s $sa shell input keyevent 66
		#sleep 1
		#adb -s $sa shell input keyevent 23
		sleep 2
		#move 578 1012		
		#sleep 2
		#move 477 673
		#sleep 3
		
		#adb -s $sa shell input keyevent 23
		 
		adb -s $sa shell input keyevent 4
		adb -s $sa shell input keyevent 4
		adb -s $sa shell input keyevent 4	
		dur=1
		
		while  [ $dur -le 60 ]; do
			sleep 1
			
		
			r="`adb -s $sb shell logcat -d -b events | grep "com.android.mms" | grep "Receive"`"
			if [ -n "$r"  ];then  #-n STRING 如果STRING的长度非零则为真
				echo ""	
				echo "`date`: Msg recieved!"
				result "s1"
				adb -s $sb shell logcat -b events -c 
				sleep 5
				break
			fi
			if [ $dur -eq 60 ];then
				echo \n
				echo "`date`: Msg not recieved! Now catching logs"
				loger
				result "s0"
				adb -s $sb shell logcat -b events -c 
				doom=1
				break
			fi
			dur=$((dur+1))
		done
		[ $doom -eq 1 ] && n=$((n+1)) && continue
		n=$((n+1))
	done
}

result()
{
	case $1 in
		m1) echo "`date`: $n, MMS received." >> ./result.txt;;
		m0) echo "`date`: $n, MMS received failed." >> ./result.txt;;
		s1) echo "`date`: $n, SMS received." >> ./result.txt;;
		s0) echo "`date`: $n, SMS received failed" >> ./result.txt;;
	esac
}

main()
{
	
	echo "`date`: Input number of Target phone:Phone B"
	read num
	echo "`date`: Input the devices number of MT phone:Phone B"
	read sb
	echo "`date`: Input the devices number of MO phone: Phone A"
	read sa
	echo "loop number:"
	read tn
	
	$1 
}
shtime="`date +%y%m%d%H%M%S`"
mkdir -p Msg_$shtime
cd Msg_$shtime
rm -fr ./[Rr]esult.txt
main $@ 2>&1 | tee Msg.log
