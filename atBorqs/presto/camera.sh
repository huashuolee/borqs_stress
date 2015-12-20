#!/bin/bash
for (( n=1; n<=1000; n++ ))
do
   adb shell input keyevent 27   
   sleep 2
   echo $n
done
echo "done"

