#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/Caffeinemark/Caffeinemark-FlexyCore-1.2.4.apk
sleep 1
echo "sync && echo 3 > /proc/sys/vm/drop_caches"
sleep 1
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/Caffeinemark/classes.dex /data/CFM.dex
sleep 1
echo "adb shell dalvikvm -cp /data/CFM.dex CaffeineMarkEmbeddedApp"
