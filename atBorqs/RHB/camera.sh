#!/bin/bash
echo "input devices number:"
read s
echo "count"
read count
i=1
while [ $i -le $count ]; do	
	
	adb -s $s "wait-for-device"	
	adb -s $s shell input keyevent 27
	sleep 2	
	echo $i
	echo ` date `		
	
i=$((i+1))
done		
