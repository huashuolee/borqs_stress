#!/bin/sh
########
# Created by Luke
# Mail: luke.zhang@borqs.com
########


mt()
{
	
	echo $1
	n=$1
	[ -z "$1" ] && n=100
	echo "`date`: ############\nA call B(PUT),\n$n times.\n###########"
	echo "`date`: Please input phone number A:"
	read na
	echo "`date`: Please input phone number B:"
	read nb
	echo "`date`: Input the devices number of phone A"
	read sa
	echo "`date`: Input the devices number of phone B"
	read sb

	adb -s $sa root
	adb -s $sa remount
	adb -s $sb root
	adb -s $sb remount
	sleep 5

	adb -s $sa shell input keyevent 4
	adb -s $sb shell input keyevent 4
	#echo "`date`: Verifing devices..."
	#[ -n "$isfrance" -a -z "`echo $nb | grep "+"`" ] && nb="+$nb"
	#[ -n "$isfrance" ] && na="`echo $na | tr -d +`"
	#adb -s $sa shell am start -a android.intent.action.CALL -d tel:$nb
	#adb -s $sa shell input keyevent 5
	#sleep 1
	#adb -s $sa shell input text $nb # sb?=nb
	#sleep 1
	#adb -s $sb logcat -b radio -c
	#adb -s $sa shell input keyevent 5
	#sleep 10
	#if [ -z "`adb -s $sb logcat -d -b radio | grep "Event EVENT_CALL_RING Received state=RINGING"`" ]; then
	#	tmp=$sa
	#	export sa=$sb
	#	export sb=$tmp
	#	sleep 3
	#fi
	adb -s $sb shell input keyevent 6
	#adb -s $sb shell input keyevent 6
	#adb -s $sa shell input keyevent 6
	#adb -s $sa shell input keyevent 6
	#echo "`date`: Ending verifacation.."
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
		doom=0
		echo "`date`: Now, dialing $i of $n.."
		adb -s $sa shell am start -a android.intent.action.CALL -d tel:$nb
		#adb -s $sa shell input keyevent 5
		sleep 1
		#adb -s $sa shell input text $nb # sb?=nb
		#sleep 1
		adb -s $sb logcat -b radio -c
		adb -s $sb logcat -c
		adb -s $sa logcat -b radio -c
		adb -s $sa logcat -c
		#adb -s $sa shell input keyevent 5
		echo "`date`: Dialing $nb"
		##########dial out###########
		dur=1
		while  [ $dur -le 60 ]; do # timer
			sleep 1
			r="`adb -s $sb logcat -d -b radio | grep "Event EVENT_CALL_RING Received state=RINGING"`" #key turnner
			if [ -n "$r"  ];then
				sleep 5
				echo "`date`: MO call shall in, now answer it!"
				result "td1"
				cleanup "-s" "$sb"
				cleanup "-s" "$sa"
				adb -s $sb shell input keyevent 5
				break
			fi
			if [ $dur -eq 60 ];then	#time out
				echo "`date`: Not dialed out, catching logs now."
				result "td0"
				adb -s $sa pull /data/logs/ ./"$i"_logs/AMT_log
				adb -s $sa pull /data/anr/ ./"$i"_logs/AMT_log
				adb -s $sa pull /data/logs/panic/ ./"$i"_logs/AMT_log
				adb -s $sb pull /data/logs/ ./"$i"_logs/BMT_log
				adb -s $sb pull /data/anr/ ./"$i"_logs/BMT_log
				adb -s $sb pull /data/logs/panic/ ./"$i"_logs/BMT_log
				cleanup "-s" "$sb"
				cleanup "-s" "$sa"
				doom=1
				break
			fi
			dur=$((dur+1))
		done
		[ $doom -eq 1 ] && i=$((i+1)) && continue
		##########Answer call##############
		dur=1
		while  [ $dur -le 60 ]; do #Timer	
			sleep 1
			r="`adb -s $sb logcat -d -b radio | grep "parent=ACTIVE"`" #key turnner
			if [ -n "$r"  ];then
				echo "`date`: Answered."
				result "ta1"
				cleanup "-s" "$sb"
				cleanup "-s" "$sa"
				sleep 3
				break
			fi
			if [ $dur -eq 60 ];then	#time out
				echo "`date`: The call is not answered!"
				result "ta0"
				echo "`date`: Catching logs now."
				adb -s $sa pull /data/logs/ ./"$i"_logs/AMT_log
				adb -s $sa pull /data/anr/ ./"$i"_logs/AMT_log
				adb -s $sa pull /data/logs/panic/ ./"$i"_logs/AMT_log
				adb -s $sb pull /data/logs/ ./"$i"_logs/BMT_log
				adb -s $sb pull /data/anr/ ./"$i"_logs/BMT_log
				adb -s $sb pull /data/logs/pani/c ./"$i"_logs/BMT_log
				cleanup "-s" "$sb"
				cleanup "-s" "$sa"
				doom=1
				break
			fi
			dur=$((dur+1))
		done
		[ $doom -eq 1 ] && i=$((i+1)) && continue
		echo "`date`: MT call will be ended."
		adb -s $sa shell input keyevent 6
		#adb -s $sa shell input keyevent 6
		dur=1
		while true;do
			#ra="`adb -s $sa logcat -d | grep "onStop: state = IDLE"`"
			rb="`adb -s $sb logcat -b radio -d | grep "onVoiceCallEnded"`"
			sleep 1
			#[ -n "$ra" -a -n "$rb" ] && endcallok=1 || endcallok=0
			[ -n "$rb" ] && endcallok=1 || endcallok=0
			if [ $endcallok -eq 1 ];then
				echo "`date`: Ended."
				cleanup "-s" "$sb"
				cleanup "-s" "$sa"
				result "te1"
				sleep 3
				break
			fi
			if [ $dur -eq 30 ];then	#time out
				#[ -n "$ra" ] && callsta=1 || callsta=0
				[ -n "$rb" ] && callstb=1 || callstb=0
				echo "`date`: End call failed"
				result "te0"
				echo "`date`: B: $callstb"
				echo "`date`: Catching logs now."
				adb -s $sa pull /data/logs/ ./"$i"_logs/AMT_log
				adb -s $sa pull /data/anr/ ./"$i"_logs/AMT_log
				adb -s $sa pull /data/logs/panic/ ./"$i"_logs/AMT_log
				adb -s $sb pull /data/logs/ ./"$i"_logs/BMT_log
				adb -s $sb pull /data/anr/ ./"$i"_logs/BMT_log
				adb -s $sb pull /data/logs/panic/ ./"$i"_logs/BMT_log
				cleanup "-s" "$sb"
				cleanup "-s" "$sa"
				doom=1
				break
			fi
			dur=$((dur+1))
		done
		[ $doom -eq 1 ] && i=$((i+1)) && continue
		i=$((i+1))
	done
}




cleanup()
{
	adb $1 $2 shell rm -r /data/logs/aplog.log.[0-9][0-9] > /dev/null
	adb $1 $2 shell rm -r /data/logs/aplog.log.[456789] > /dev/null
	adb $1 $2 shell rm -r /data/logs/bplog.* > /dev/null
	adb $1 $2 shell rm -r /data/logs/logcat-ril.log.[345] > /dev/null
}


mo()
{
	i=1
	n=$1
	[ -z "$1" ] && export n=100
	[ -z "$monum" ] && monum=10010
	adb $2 $sb shell input keyevent 4
	adb $2 $sb shell input keyevent 4
	remountadb "$2 $sb"
	echo "`date`: ###########\nCall $monum, $n times.\n###########"
	while [ $i -le $n ]; do
		doom=0
		echo "`date`: `date`,$i of $n:"
		adb $2 $sb logcat -b radio -c
		adb $2 $sb logcat -c
		adb $2 $sb shell am start -a android.intent.action.CALL -d tel:$monum
		#adb $2 $sb shell input keyevent 5
		sleep 1
		#adb $2 $sb shell input text 10011
		sleep 1
		#adb $2 $sb shell input keyevent 5
		sleep 1
		dur=1
		while  [ $dur -le 60 ]; do # timer
			sleep 1
			r="`adb $2 $sb logcat -d -b radio | grep $monum`" #key turnner
			#r="`adb $2 $sb logcat -d -b radio | grep DIALING`"
			if [ -n "$r"  ];then
				echo "`date`: Dialing..."
				result "od1"
				cleanup "$2" "$sb"
				break
			fi
			if [ $dur -eq 60 ];then	#time out
				echo "`date`: Not dialed out, catching logs now."
				adb $2 $sb pull /data/logs/ ./"$i"_logs/AMO_log
				adb $2 $sb pull /data/anr/ ./"$i"_logs/AMO_log
				adb $2 $sb pull /data/logs/panic/ ./"$i"_logs/AMO_log
				result "od0"
				cleanup "$2" "$sb"
				doom=1
				break
			fi
			dur=$((dur+1))
		done
		[ $doom -eq 1 ] && i=$((i+1)) && continue
		dur=1
		while [ $dur -le 60 ]; do
			sleep 1
			r="`adb $2 $sb logcat -d -b radio | grep "parent=ACTIVE"`"
			#r="`adb $2 $sb logcat -d -b radio | grep "ACTIVE"`"
			if [ -n "$r"  ];then
				echo "`date`: Connected."
				result "oc1"
				cleanup "$2" "$sb"
				break
			fi
			if [ $dur -eq 60 ];then
				echo "`date`: The call is not conected!!"
				echo "`date`: Failed at $i times."
				echo "`date`: Catching logs now."
				adb $2 $sb pull /data/logs/ ./"$i"_logs/AMO_log
				adb $2 $sb pull /data/anr/ ./"$i"_logs/AMO_log
				adb $2 $sb pull /data/logs/panic/ ./"$i"_logs/AMO_log
				cleanup "$2" "$sb"
				result "oc0"
				doom=1
				break
			fi
			dur=$((dur+1))
		done
		[ $doom -eq 1 ] && i=$((i+1)) && continue
		sleep 3
		echo "`date`: End."
		adb $2 $sb shell input keyevent 6
		sleep 1
		adb $2 $sb shell input keyevent 4
		sleep 1
		i=$((i+1))
	done
}

usage()
{
	echo "Usage: [-n MO_NUMBER] [-o] [-t] [-a] [COUNT] [-h]
	Option:
	-n	Number for MO call, default is 10010. Need add before -o or -a.
	-o	Test MO call.
	-t	Test MT call.
	-a	Test MT and MO call.
	-h	Show this help.
	COUNT:
	Input a number for call times."
}

result()
{
	case $1 in
		td1) echo "`date`: $i, MT dial pass" >> ./result.txt;;
		td0) echo "`date`: $i, MT dial failed, NO MO call in" >> ./result.txt;;
		ta1) echo "`date`: $i, MT answer pass" >> ./result.txt;;
		ta0) echo "`date`: $i, MT answer failed" >> ./result.txt;;
		te1) echo "`date`: $i, MT call end pass" >> ./result.txt;;
		te0) echo "`date`: $i, MT call end failed" >> ./result.txt;;
		od1) echo "`date`: $i, MO call dial pass" >> ./result.txt;;
		od0) echo "`date`: $i, MO call dial fialed" >> ./result.txt;;
		oc1) echo "`date`: $i, MO call connect pass" >> ./result.txt;;
		oc0) echo "`date`: $i, MO call connect failed" >> ./result.txt;;
	esac
}


main()
{
	adb kill-server
	adb start-server
	while getopts "fo:t:a:n:h" opt; do
		case $opt in
			f) isfrance=true;;
			n) monum=$OPTARG;;
			o) mo $OPTARG;;
			t) mt $OPTARG;;
			a) mt $OPTARG;
				mo $OPTARG "-s";
				;;
			h) usage;;
			\?) usage;;
			*) usage;;
		esac
	done
}


shtime="`date +%y%m%d%H%M%S`"
mkdir -p MOMT_$shtime
cd MOMT_$shtime
rm -fr ./[Rr]esult.txt
main $@ 2>&1 | tee ./MOMT.txt
cd ..






# menu 82
# down 20 left 21 right 22 up 19
# centre 23
# end call 6
# enter 66
