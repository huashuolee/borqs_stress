#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss push /home/b565/work/script/LHStry/pnp/busybox /system/bin/
adb $ss shell chmod 777 /system/bin/busybox
adb $ss shell mkdir /data/large/
for n in $(seq 1 100)
do
   adb $ss shell busybox dd if=/dev/zero of=/data/large/big$n.dat bs=100M count=1
   echo $n
   sleep 2
done
echo "done"

