#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"

for (( n=1; n<=$2; n++ ))
do
    adb $ss shell am start -n com.android.gallery3d/com.android.camera.CameraLauncher
    sleep 3
    adb $ss shell input keyevent 27
    sleep 3
    adb $ss shell input keyevent 4
    echo "$n"
done
echo "done"

