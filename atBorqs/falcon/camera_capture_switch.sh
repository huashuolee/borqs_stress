#!/bin/bash
switch(){
    echo "switch the camera"
    adb $ss shell input tap 490 916
    sleep 2
    adb $ss shell input tap 144 408
    sleep 2
    
}

capture(){
    for (( n=1; n<=10; n++ ))
    do
        adb $ss shell input keyevent 27   
        sleep 3
        echo $n
    done
}

ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss shell am start com.android.gallery3d/com.android.camera.CameraLauncher
for ((i=1; i<=100; i++))
do
echo "loop $i ……"     
switch
done
echo "done"

