#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
for (( n=1; n<=1000; n++ ))
do
   #adb $ss shell input tap 233 162 #CITOU
   #adb $ss shell input tap 233 162 #CITOU
   sleep 1
   #adb $ss shell input tap 208 268 #LOGO
   sleep 1
   adb $ss shell input tap 204 356 #Blue
   adb $ss shell input tap 204 356 #Blue
   sleep 1
   adb $ss shell input tap 212 483 #Green
   adb $ss shell input tap 212 483 #Green
   sleep 1
   adb $ss shell input tap 206 574 #Orange
   adb $ss shell input tap 206 574 #Orange
   sleep 1
   adb $ss shell input tap 214 672 # Red
   adb $ss shell input tap 214 672 # Red
   echo $n
done
echo "done"

