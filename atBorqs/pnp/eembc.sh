#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/EEMBC_icc11/eembc_icc11.tar.gz /data/
sleep 1
adb $ss shell busybox tar -xzvf /data/eembc_icc11.tar.gz -C /data/
sleep 1
adb $ss shell sync 
sleep 1
adb $ss shell echo 3 > /proc/sys/vm/drop_caches
sleep 1
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/EEMBC_icc11/eembc.sh /data/eembc_icc11/
sleep 1
adb $ss shell chmod 777 /data/eembc_icc11/*
sleep 2
echo "Done, e.g. ./eembc.sh 4(thread) 3(iterations)"
