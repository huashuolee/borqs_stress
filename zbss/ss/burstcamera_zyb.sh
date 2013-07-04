#!/bin/bash
mkdir -p ./"`date +%y%m%d`"_BurstCamera-ZYB
cd ./"`date +%y%m%d`"_BurstCamera-ZYB
main()
{
	if [ "`adb get-state`" = "unknown" ];then
		echo "No devices!"
		exit 1
	fi
	echo "Please input capture times:"
	read num
	i=1
	dur=1
	#Intent { act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=com.intel.camera/.Camera bnds=[306,507][442,652] } from pid 1596
	while [ $i -le $num ];do	
		echo "`date +%X`"--"capture $i of $num"	
		# adb -s MedfieldA4AD65C1 shell logcat -c
		# sleep 1
		adb -s MedfieldA4AD65C1 shell input keyevent 27
		sleep 6
		# dur=1
		# while true;do
			# qqq="`adb -s MedfieldA4AD65C1 logcat -d | grep "after stored burst image 10"`"
			# if [ -n "$qqq" ];then
				# echo "`date +%X`"--"Capture complete"
				# break
			# fi
			# if [ $dur -eq 5 ];then
				# echo "`date +%X`"--"Capture failed"
				# adb -s MedfieldA4AD65C1 pull /data/logs/ ./burststress1
				# exit 1
			# fi
			# dur=$((dur+1))
		# done
		# sleep 1
		i=$((i+1))
	done
	echo "Test Over~"
}
main 2>&1 | tee ./BurstCamera1.txt
cd ..