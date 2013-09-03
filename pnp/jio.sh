#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/JIOV1.6/JIO_V1.6.apk
adb $ss shell chmod 777 /data
echo "change the work location to /data/jio.test"
