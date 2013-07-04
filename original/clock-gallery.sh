#!/bin/bash

move()
{
	adb shell input motionevent $1 $2 down
	adb shell input motionevent $1 $2 up
}


[[ -z $1 ]] && n=100 || n=$1
l=1
adb shell am start -n com.android.deskclock/.DeskClock
sleep 1
while [ $l -le $n ];do
	echo "Loop, $l of $n"
	echo "Launch gallery."
	move 230 950
	sleep 1
	echo "Back to clock."
	adb shell input keyevent 4
	sleep 1
	echo ""
done
echo "Done!"
