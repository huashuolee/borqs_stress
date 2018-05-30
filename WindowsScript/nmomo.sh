#!/bin/sh


test()
{
	if [ "`adb get-state`" = "unknown" ];then
		echo "Device not found!"
		dur=60
	fi
}





mt()
{
	echo $1
	n=$1
	[ -z "$1" ] && n=100
	echo "############\nA call B(PUT),\n$n times.\n###########"
	echo "Please input number A:"
	read na
	echo "Please input number B:"
	read nb
	export sa=`adb devices | awk 'NR==2 {printf $1}'`
	export sb=`adb devices | awk 'NR==3 {printf $1}'`
	adb -s $sa shell input keyevent 4
	adb -s $sb shell input keyevent 4
	echo "Verifing devices..."
	adb -s $sa shell am start -a android.intent.action.CALL -d tel:$nb
	adb -s $sa shell input keyevent 5
	sleep 1
	#adb -s $sa shell input text $nb # sb?=nb
	#sleep 1
	adb -s $sb logcat -b radio -c
	adb -s $sa shell input keyevent 5
	sleep 10
	if [ -z "`adb -s $sb logcat -d -b radio | grep $na`" ]; then
		tmp=$sa
		export sa=$sb
		export sb=$tmp
		sleep 3
	fi
	adb -s $sb shell input keyevent 6
	#adb -s $sb shell input keyevent 6
	adb -s $sa shell input keyevent 6
	#adb -s $sa shell input keyevent 6
	echo "Ending verifacation.."
	adb -s $sa shell input keyevent 4
	adb -s $sa shell input keyevent 4
	adb -s $sb shell input keyevent 4
	adb -s $sb shell input keyevent 4
	adb -s $sa shell input keyevent 4
	adb -s $sb shell input keyevent 4
	adb -s $sa shell input keyevent 4
	adb -s $sb shell input keyevent 4
	adb -s $sa shell input keyevent 4
	adb -s $sb shell input keyevent 4
	i=1
	sleep 5
	while [ $i -le $n ]; do
		echo "Now, dialing $i of $n.."
		adb -s $sa shell am start -a android.intent.action.CALL -d tel:$nb
		#adb -s $sa shell input keyevent 5
		sleep 1
		#adb -s $sa shell input text $nb # sb?=nb
		#sleep 1
		adb -s $sb logcat -b radio -c
		adb -s $sb logcat -c
		#adb -s $sa shell input keyevent 5
		echo "Dialing $nb"
		##########dial out###########
		dur=1
		while  [ $dur -le 60 ]; do # timer
			
			sleep 1
			r="`adb -s $sb logcat -d -b radio | grep $na`" #key turnner
			if [ -n "$r"  ];then
				sleep 5
				echo "MO call shall in, now answer it!"
				adb -s $sb shell input keyevent 5
				break
			fi
			if [ $dur -eq 60 ];then	#time out
				echo "Not dialed out, catching logs now."
				echo $'\a';echo $'\a';echo $'\a'
				adb -s $sa pull /data/logs ./AMT_log
				adb -s $sa pull /data/anr ./AMT_log
				adb -s $sa pull /data/logs/panic ./AMT_log
				adb -s $sb pull /data/logs ./BMT_log
				adb -s $sb pull /data/anr ./BMT_log
				adb -s $sb pull /data/logs/panic ./BMT_log
				echo "Failed at No.$i."
				exit 1
			fi
			dur=$((dur+1))
		done
		##########Answer call##############
		dur=1
		while  [ $dur -le 60 ]; do #Timer
			
			sleep 1
			r="`adb -s $sb logcat -d -b radio | grep "parent=ACTIVE"`" #key turnner
			if [ -n "$r"  ];then
				echo "Answered."
				sleep 3
				echo "MT call will be ended."
				adb -s $sa shell input keyevent 6
			#	adb -s $sa shell input keyevent 6
				sleep 1
				echo "Ended."
				adb -s $sa shell input keyevent 4
				adb -s $sa shell input keyevent 4
				adb -s $sb shell input keyevent 4
				adb -s $sb shell input keyevent 4
				sleep 3
				break
			fi
			if [ $dur -eq 60 ];then	#time out
				echo "The call is not answered!"
				echo "Failed at No.$i."
				echo "Catching logs now."
				echo $'\a';echo $'\a';echo $'\a'
				adb -s $sa pull /data/logs ./AMT_log
				adb -s $sa pull /data/anr ./AMT_log
				adb -s $sa pull /data/logs/panic ./AMT_log
				adb -s $sb pull /data/logs ./BMT_log
				adb -s $sb pull /data/anr ./BMT_log
				adb -s $sb pull /data/logs/panic ./BMT_log
				exit 1
			fi
			dur=$((dur+1))
		done
		i=$((i+1))
	done
}

mo()
{
	i=1
	n=$1
	[ -z "$1" ] && export n=100
	adb $2 $sb shell input keyevent 4
	adb $2 $sb shell input keyevent 4
	echo "###########\nCall 10011, $n times.\n###########"
	while [ $i -le $n ]; do
		echo "`date`,$i of $n:"
		adb $2 $sb shell am start -a android.intent.action.CALL -d tel:10011
		#adb $2 $sb shell input keyevent 5
		sleep 1
		#adb $2 $sb shell input text 10011
		adb $2 $sb logcat -b radio -c
		adb $2 $sb logcat -c
		sleep 1
		#adb $2 $sb shell input keyevent 5
		sleep 1
		dur=1
		while  [ $dur -le 60 ]; do # timer
			
			sleep 1
			r="`adb $2 $sb logcat -d -b radio | grep 10011`" #key turnner
			if [ -n "$r"  ];then
				echo "Dialing..."
				break
			fi
			if [ $dur -eq 60 ];then	#time out
				echo "Not dialed out, catching logs now."
				echo $'\a';echo $'\a';echo $'\a'
				adb $2 $sb pull /data/logs ./AMO_log
				adb $2 $sb pull /data/anr ./AMO_log
				adb $2 $sb pull /data/logs/panic ./AMO_log
				echo "Failed at No.$i."
				exit 1
			fi
			dur=$((dur+1))
		done
		dur=1
		while  [ $dur -le 60 ]; do
			
			sleep 1
			r="`adb $2 $sb logcat -d -b radio | grep "parent=ACTIVE"`"
			if [ -n "$r"  ];then
				echo "Connected."
				break
			fi
			if [ $dur -eq 60 ];then
				echo "The call is not conected!!"
				echo "Failed at $i times."
				echo "Catching logs now."
				echo $'\a';echo $'\a';echo $'\a'
				adb $2 $sb pull /data/logs ./AMO_log
				adb $2 $sb pull /data/anr ./AMO_log
				adb $2 $sb pull /data/logs/panic ./AMO_log
				exit 1
			fi
			dur=$((dur+1))
		done
		sleep 3
		echo "End."
		adb $2 $sb shell input keyevent 6
		sleep 1
		adb $2 $sb shell input keyevent 4
		sleep 1
		i=$((i+1))
	done
}

usage()
{
	echo "	Usage:[-o] [-t] [-a] [COUNT] [-h]
	Option:
	-o	Test MO call.
	-t	Test MT call.
	-a	Test MT and MO call.
	-h	Show this help.
	COUNT:
	Input a number for call times."
}

main()
{
	opt="$1"; num="$2"
	if [ "$opt" = "-o" ] && [ "`echo $num | grep '[0-9]'`" != "" ] ;then
		mo $2 
	elif [ "$opt" = "-t" ] && [ "`echo $num | grep '[0-9]'`" != "" ] ;then
		mt $2
	elif [ "$opt" = "-a" ] && [ "`echo $num | grep '[0-9]'`" != "" ] ;then
		mt $2
		mo $2 "-s"
	elif [ "$opt" = "-h" ];then
		usage
		exit
	elif [ -n "$num" ] && [ "`echo $num | grep '[0-9]'`" = "" ];then
		echo "Please input a number for times."
		usage
		exit 1
	else
		echo "Unknown option: $opt $num"
		usage
		exit 1
	fi
}


mkdir -p ./MOMT"_`date +%y%m%d`"
cd ./MOMT"_`date +%y%m%d`"
main $@ 2>&1 | tee ./MOMT.txt
cd ..






# menu 82
# down 20 left 21 right 22 up 19
# centre 23
# end call 6
# enter 66
