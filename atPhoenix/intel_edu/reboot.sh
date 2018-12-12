#!/bin/bash


function connect(){
while true
do
    adb disconnect 2>&1 > /dev/null
    adb connect $1 2>&1 > /dev/null
    sn=`adb devices | awk 'NR==2 {printf $1}'`
    if [[ $sn = "$1:5555" ]];then
        break
    fi
done
}

for i in `seq 1 100`
do
    echo `date +%Y%m%d-%H:%M` ": the $i time"
    connect $1 
    adb wait-for-device reboot
    sleep 20
done
