#!/bin/bash

leak()
{
	sleep 2
	rm -fr ./tpid
	#echo L, $pkg
	#n=`cat ./tmp`
	mkdir -p ./$n"_"$pkg/$pkg"_Leak"
	needpid=""
	export needpid=`tail -n 1 ./$n"_"$pkg/"monkey_"$pkg.txt | awk '{printf $2$3$4}'`
	echo "`date +%X`: Get monkey status..."
	while [ "$needpid" != "Noactivitiesfound" ];do
		echo "`date +%X`: Start recording memory!"
		#adb $ss shell procrank | head -n 1 > ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls"
		export lpkg="$pkg"
		[ "$pkg" = "com.android.contacts" ] && export lpkg="android.process.acore"
		adb $ss shell procrank | grep $lpkg | tee -a ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls"
		export looped=1
		if [ -z $pid ]; then
			echo "`date +%X`: PID is not set."
			#cat ./$n"_"$pkg/$pkg"_emory.txt" | awk 'NR==3 {printf $1}' > ./tmp.txt
			echo "`date +%X`: Writing PID..."
			export pid=`cat ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls" | awk 'NR==1 {printf $1}' | tee ./tpid`
			echo "`date +%X`: PID is $pid." 
		fi
		export vpid=`cat ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls" | awk 'NR=='$looped' {printf $1}'`
		if [ "$vpid" != "$pid" ];then
			echo "`date +%X`: PID changed! Set it again."
			export pid=$vpid
			echo $pid > ./tpid
			echo "`date +%X`: PID change to $pid"
		fi
		export looped=$((looped+1))
		sleep 20
	done
	echo "`date +%X`: No need to test leak issue."
	echo -e "$n\t$pkg\tN/A\tN/A\tBlock" >> ./emory_leak_result.xls
	rm -fr ./$n"_"$pkg/$pkg"_Leak"


}




checkleak()
{
	if [ "$leak" = "y" ]; then
		echo "`date +%X`: Start checking memory"
		adb $ss shell kill -10 `cat ./tpid`
		adb $ss shell procrank | grep $mpkg | tee -a ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls"
		echo "`date +%X`: General files, please wait 10 seconds..."
		sleep 10
		adb $ss shell procrank | grep $mpkg | tee -a ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls"
		hanguss=`grep -c "" ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls"`
		firstuss=`cat ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls" | grep $pkg | awk 'NR==1 {printf $5}' | tr -cd "[0-9]"`
		lastuss=`cat ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls" | grep $pkg | awk 'NR=='$hanguss' {printf $5}' | tr -cd "[0-9]"`
		echo $lastuss $firstuss
		if [ $((lastuss-firstuss)) -ge 3072 ]; then
			echo "`date +%X`: $pkg is Fail for leak test."
			echo -e "$n\t$pkg\t$firstuss\t$lastuss\tFail" >> ./emory_leak_result.xls
			echo "`date +%X`: Pulling files"
			loger
			adb $ss pull /data/misc ./$n"_"$pkg/$pkg"_Leak"/
			rm -r ./$n"_"$pkg/$pkg"_Leak"/*/
			#mv ./$n"_"$pkg/$pkg.txt ./$n"_"$pkg/$pkg"_Leak"/
			mv ./$n"_"$pkg/$pkg"_Leak"/*.hprof ./$n"_"$pkg/$pkg"_Leak"/$pkg.hprof 
			echo "`date +%X`: Clearing phone momory..."
			adb $ss shell rm /data/misc/*.hprof
		else
			adb $ss shell rm /data/misc/*.hprof
			echo "`date +%X`: $pkg is OK for leak test."
			echo -e "$n\t$pkg\t$firstuss\t$lastuss\tPass" >> ./emory_leak_result.xls
		fi
	fi
}


cleanup()
{
	echo "Clean up..."
	adb $ss shell input keyevent 20
	adb $ss shell input keyevent 23
	kmedia=`adb $ss shell ps | grep mediaserver | awk '{printf $2}'` 
	adb $ss shell kill -9 $kmedia
	adb $ss shell rm -r /data/logs/aplog.log.[6789]
	adb $ss shell rm -r /data/logs/aplog.log.[0-9][0-9]
	adb $ss shell rm -r /data/anr/*
	adb $ss shell rm -r /data/system/dropbox/*
}

setup()
{
	wocao=`adb devices | grep $ss`
	if [ -z "$wocao" ]; then
		echo "`date +%X`: adb is not a shit."
		exit 1
	fi
	doom=0
	pkg=""
	n=1
	lastlineok="finished"
	noact="No activities"
	adb $ss shell chmod 777 /data/misc
	echo -e "#\tPackageName\tResult\tmonkeyCommand\tComments" >> ./Result.xls
	adb $ss shell ls /data/data | grep -v test | grep -v demo | grep -v com.android.development | grep -v com.android.spare_parts > ./pkglist.txt
	hang=`grep -c "" ./pkglist.txt`
	echo "`date +%X`: Please input interval(ms),e.g.,400:"
	read interval
	echo "`date +%X`: Please input counts(int), e.g.,3000:"
	read count
	echo "`date +%X`: Testing including leak?(y/n)"
	read leak
	if [ "$leak" = "y" ]; then
		echo -e "#\tPackagName\tStartemory\tEndemory\tResult" > ./emory_leak_result.xls
	fi
	echo "`date +%X`: OS or intel?(o/i)"
	read logt
	model="`adb shell getprop ro.product.model`"
}

loger()
{
	mkdir ./$n"_"$pkg/logs
	if [ "$logt" = "i" -a -z "$1" ];then
		echo "`date +%X`: Catching logs for monkey test"
		adb $ss pull /data/logs/ ./$n"_"$pkg/logs
		adb $ss pull /data/anr ./$n"_"$pkg/logs
		adb $ss pull /data/system/dropbox/ ./$n"_"$pkg/logs
		adb $ss shell dumpstate > ./$n"_"$pkg/logs/dumpstate.txt
	elif [ "$1" = "1" ];then
		adb $ss pull /data/logs/ ./system/logs
		adb $ss pull /data/anr ./system/logs
		adb $ss pull /data/system/dropbox/ ./system/logs
		adb $ss shell dumpstate > ./$n"_"$pkg/logs/dumpstate.txt
	else
		adb $ss pull /local/log ./$n"_"$pkg/logs
	fi
	if [ "$leak" != "y" ];then
		adb $ss shell input keyevent 20
		adb $ss shell input keyevent 23
		echo "Close FC or ANR dialog."
	fi	
}

preboot()
{
	echo "`date`: Now, reboot..."
	adb $ss shell reboot
	dur=1
	while true;do
		adbstate="`adb devices | grep $ss`"
		sleep 1
		if [ -n "$adbstate" ];then
			adb $ss  logcat -d | grep "BOOT_COMPLETED" > ./Boot.log
			rpower="`cat ./Boot.log | grep "BOOT_COMPLETED"`"
			rpower2="`cat ./Boot.log | grep -i "BOOTCOMPLETED"`"
			sleep 1
			if [ -n "$rpower" -o -n "$rpower2" ]; then
				echo "Powered up!"
				break
			fi
		fi
		if [ $dur -eq 80 ];then
			echo "Phone did not power up!"
			logger
			cleanup
			exit 1
		fi
		dur=$((dur+1))
	done
	sleep 10
	echo "`date`: Unlocking..."
	adb $ss shell input motionevent 160 420 down && adb $ss shell input motionevent 280 420 move && adb $ss shell input motionevent 280 420 up
}



result()
{
	if [ "$n" = "$hang" ];then
		echo "`date +%X`: All monkeys have their bananas now."
	fi
	echo "`date +%X`: 
	###############################
	Total package: $n
	Pass: `cat ./Result.xls | grep Pass | grep -c ""`
	Fail: `cat ./Result.xls | grep Fail | grep -c ""`
	Block: `cat ./Result.xls | grep Block | grep -c ""`
	###############################
	"
	echo -e "\n\tTotal\t$((n-1))
	Pass\t`cat ./Result.xls | grep Pass | grep -c ""`
	Fail\t`cat ./Result.xls | grep Fail | grep -c ""`
	Block\t`cat ./Result.xls | grep Block | grep -c ""`
	">> ./Result.xls
	chmod 777 -R ./
	rm -fr ./tmp	
}



main()
{
	setup
	while [ -n "$wocao" ] && [ $n -le $hang ];do
		adb root
		sleep 3
		adb remount
		sleep 3
		echo $n > ./tmp
		echo "`date +%X`: $n of $hang..."
		export pkg=`head -n $n ./pkglist.txt | tail -n 1 | tr -d "\r"`
		export mpkg="$pkg"
		[ "$pkg" = "com.android.contacts" ] && export mpkg="android.process.acore"
		mkdir ./$n"_"$pkg
		echo "`date +%X`: ------------------------------------------------------------------------------------------"
		echo "`date +%X`: Try to run monkey with $pkg..."
		R=`date +%N`
		echo "`date +%X`: Seed is $R."
		sleep 1
		echo "`date +%X`: monkey runing..."
		############
		if [ "$leak" = "y" ]; then
			leak &
		fi
		############
		itmp=$interval
		if [ -n "`echo $pkg | grep camera`" ]; then 
			interval=1000
		fi
		if [ -n "`echo $pkg | grep "calendar"`" -o -n "`echo $pkg | grep "searchbox"`" ];then
			dontanr="-c android.intent.category.LAUNCHER"
		else
			dontanr=""
		fi
		adb $ss shell monkey -p $pkg -s $R -v --pct-touch 30 --throttle $interval $count $dontanr --ignore-crashes --monitor-native-crashes > ./$n"_"$pkg/"monkey_"$pkg.txt
		mcmd="adb $ss shell monkey -p $pkg -s $R -v --pct-touch 30 --throttle $interval $count $dontanr --ignore-crashes --monitor-native-crashes"
		interval=$itmp
		isnoact=`cat ./$n"_"$pkg/"monkey_"$pkg.txt | grep "$noact"`
		isok=`cat ./$n"_"$pkg/"monkey_"$pkg.txt | grep "$lastlineok"`
		if [ -n "$isnoact" ];then
			echo "`date +%X`: $pkg shall be ignore since no activities to run"
			echo -e "$n\t$pkg\tBlock\t$mcmd\tNo activities." >> Result.xls
			pboot=0
		elif [ -n "$isok" ]; then
			echo "`date +%X`: monkey ran without errors"
			pboot=1
			echo -e "$n\t$pkg\tPass\t$mcmd" >> Result.xls
			if [ "$leak" = "y" ]; then
				#leakpid=`ps -ef | grep "sh ../leak.sh" | grep -v grep | tail -n 1 | awk '{printf $2}'`
				echo "`date +%X`: Releasing momery, please wait 10 seconds..."
				adb $ss shell input keyevent 4
				adb $ss shell input keyevent 4
				adb $ss shell input keyevent 4
				adb $ss shell input keyevent 4
				adb $ss shell input keyevent 4
				sleep 30
				echo "`date +%X`: Ending Leak recorder...."
				jobs
				njobs="`jobs | tail -n 1 | tr -cd '0-9'`"
				kill -9 %$njobs
				adb $ss shell procrank | grep $mpkg | tee -a ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls"
			fi
			checkleak
		else
			echo "`date +%X`: Error happened.."
			pboot=1
			wocao=`adb devices | grep $ss`
			if [ -z "$wocao" ]; then
				echo "`date +%X`: adb $ss disconected...."
				echo "`date +%X`: Ending Leak testing...."
				jobs
				njobs="`jobs | tail -n 1 | tr -cd "0-9"`"
				kill -9 %$njobs
				echo "`date +%X`: Test stop at $pkg"
				echo "`date +%X`: Test stop at $pkg"
				echo "`date +%X`: Test stop at $pkg"
				echo -e "$n\t$pkg\tBlock\t$mcmd\tadb $ss disconected." >> Result.xls
				echo "`date +%X`: Try to wait phone recover.."
				recv=0
				while true;do
					wocao=`adb devices | grep $ss`
					if [ -z "$wocao" ];then
						echo "`date +%X`: Still not.."
						sleep 1
						recv=$((revc+1))
					else
						echo "`date +%X`: ADB is ok again, continue.."
						doom=0
						break
					fi
					if [ $recv -eq 60 ]; then
						echo "`date +%X`: Timeout.. All failed"
						doom=1
						break
					fi
				done
					
			else
				echo -e "$n\t$pkg\tFail\t$mcmd\tPlease check logs." >> Result.xls
				sleep 3
				if [ "$leak" = "y" ]; then
				#	leakpid=`ps -ef | grep "sh ../leak.sh" | grep -v grep | tail -n 1 | awk '{printf $2}' `
					echo "`date +%X`: Releasing momery, please wait 10 seconds..."
					adb $ss shell input keyevent 4
					adb $ss shell input keyevent 4
					adb $ss shell input keyevent 4
					adb $ss shell input keyevent 4
					adb $ss shell input keyevent 4
					adb $ss shell input keyevent 4
					adb $ss shell input keyevent 4
					sleep 30
					echo "`date +%X`: Ending Leak testing...."
					jobs
					njobs="`jobs | tail -n 1 | tr -cd "0-9"`"
					kill -9 %$njobs
					adb $ss shell procrank | grep $mpkg | tee -a ./$n"_"$pkg/$pkg"_Leak"/$pkg"_emory.xls"
				fi
				checkleak
				loger
				kmedia=`adb $ss shell ps | grep mediaserver | awk '{printf $2}'` 
				adb $ss shell kill -9 $kmedia
				adb $ss shell input keyevent 20
				adb $ss shell input keyevent 23
				echo "Multimedia server killed."
			fi
		fi
		n=$((n+1))
		echo "`date +%X`: Start next loop in 10s..."
		sleep 10
		[[ $pboot -eq 1 ]] && preboot
	done
	[ $doom -eq 0 ] && system
	result
}

system()
{
	echo "Now, start system monkey test."
	mkdir -p ./system
	adb $ss shell monkey -s $R -v --pct-touch 30 --throttle 50 100000 --ignore-crashes --monitor-native-crashes > ./system/monkey.log
	mcmd="adb $ss shell monkey -s $R -v --pct-touch 30 --throttle $interval $count --ignore-crashes --monitor-native-crashes"
	lastline=`tail -n 1 ./system/monkey.log | cut -c 11-18`
	if [ "$lastline" = "$lastlineok" ]; then
		echo "`date +%X`: monkey ran without errors"
		echo -e "System\tSystem\tPass\t$mcmd" >> Result.xls
	else
		echo "`date +%X`: Error happened.."
		wocao=`adb devices | grep $ss`
		if [ -z "$wocao" ]; then
			echo "`date +%X`: adb $ss disconected...."
			echo -e "System\tSystem\tBlock\t$mcmd\tadb $ss disconected." >> Result.xls
		else
			echo -e "System\tSystem\tFail\t$mcmd\tPlease check logs." >> Result.xls
			sleep 3
			loger 1
		fi
	fi

}

rm -fr ./monkey"_`date +%y%m%d`"
mkdir -p ./monkey"_`date +%y%m%d`"
cd ./monkey"_`date +%y%m%d`"
ss="-s $1"
[[ -z $1 ]] && ss=""
main 2>&1 | tee ./monkey.log
