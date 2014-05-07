#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1" # 判断变量是否有值

adb $ss "wait-for-device" root
adb $ss "wait-for-device" remount
adb $ss push /home/b565/work/script/LHStry/pnp/busybox /system/bin
adb $ss shell chmod 777 /system/bin/busybox

echo "Done"
