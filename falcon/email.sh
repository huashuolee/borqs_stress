#!/bin/bash

send() {
    echo "Round $1: `date`: Start compose mail"
    adb -s  $device shell am start -n com.android.email/.activity.MessageCompose
    adb -s  $device shell input text test201002230319@gmail.com
    sleep 2
    adb -s  $device shell input tap 55 310 
    sleep 2
    adb -s  $device shell input text Round_$1
    sleep 2
    adb -s  $device shell input tap 70 380

    t=`date +"%T"`
    adb -s  $device shell input text Round_$1_at_$t
    sleep 2
    #adb -s  $device shell input keyevent 4
    adb -s  $device shell input tap 520 55

    echo "Round $1: `date`: Sent."
}
i=1
device=$1
echo $device
for (( ; ; ))
do
    i=$[i+1]
    send $i
    sleep  10
done

