#!/bin/bash
move()
{
	adb shell input motionevent $1 $2 down
	adb shell input motionevent $1 $2 up
}

echo "Times of loop:"
read t
n=1
while [ $n -le $t ];do
	echo "`date`: $n of $t"
	adb shell am start -n com.android.soundrecorder/.SoundRecorder -W
	sleep 1
	echo "Start recording."
	move 170 965
	sleep 5
	echo "Stopped."
	move 430 965
	sleep 1
	echo "Pre-play."
	move 300 965
	sleep 7
	echo "Save and exit"
	move 160 725
	sleep 1
	n=$((n+1))
done
