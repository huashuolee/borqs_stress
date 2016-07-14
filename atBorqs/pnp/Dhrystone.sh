#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"

adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/Dhrystone_icc-12-0-3-20110309/dhrystone /data/
adb $ss shell chmod 0777 /data/dhrystone
adb $ss shell sync
adb $ss shell echo 3 > /proc/sys/vm/drop_caches

echo "/data/dhrystone & dhrystone & dhrystone& dhrystone"
echo "DMIPS for main thread/score is 2* min (score1, score2)."

