#!/bin/bash
move()
{
	adb shell input motionevent $1 $2 down
	adb shell input motionevent $1 $2 up
}
echo "Times of input:"
read t
echo "Start! `date`"
n=1
while [ $n -le $t ];do
	seed=$((RANDOM%13))
	case $seed in
	1) move 100 400;;
	2) move 300 400;;
	3) move 500 400;;
	4) move 100 530;;
	5) move 300 530;;
	6) move 500 530;;
	7) move 100 650;;
	8) move 300 650;;
	9) move 500 650;;
	10) move 100 780;;
	11) move 300 780;;
	12) move 500 780;;
	esac
	n=$((n+1))
done
echo "Over! `date`"
