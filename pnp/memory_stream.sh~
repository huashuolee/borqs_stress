#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/Memory_Stream/stream_handopt.192 /data/stream
adb $ss shell chmod 777 /data/stream
echo "sync && echo 3 > /proc/sys/vm/drop_caches"
