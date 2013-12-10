#!/bin/bash
read s
for (( n=1; n<=500; n++ ))
do
   adb -s $s shell input keyevent 27   
   sleep 5
   adb -s $s shell input keyevent 27
   sleep 5
   echo $n
done
echo "done"

