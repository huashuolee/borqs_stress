#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/Linpack_0xbench/0xbench_M_v1.0.apk
sleep 1
echo "sync && echo 3 > /proc/sys/vm/drop_caches"
