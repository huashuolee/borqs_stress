#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/BasemarkES2v1_TaijiHoverJet/BasemarkES2v1/BasemarkES2v1.apk
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/BasemarkES2v1_TaijiHoverJet/BasemarkES2v1/rightware /data/rightware
adb $ss shell chmod 777 /data
adb $ss shell chmod 777 /data/rightware/
adb $ss shell chmod 777 /data/rightware/basemarkes2v1/
echo "cat /data/rightware/basemarkes2v1/fm_mobile_app_log.txt"
