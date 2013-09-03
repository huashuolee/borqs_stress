#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss "wait-for-device" root
adb $ss "wait-for-device" remount
sleep 2
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_powerKPI/ActiveIdleWifi/SPMActiveIdle-Service.apk
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_powerKPI/AudioStreaming_Wifi_MW/music_gsma_44100_128k.mp3 /sdcard/
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_powerKPI/VideoPlayback1080P/BBB_1080p_12Mbps_audio_44100_30fps_HP.mp4 /sdcard/
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_powerKPI/5-StillCapture/camera2_usermode.sh /data/
adb $ss shell chmod 777 /data/camera2_usermode.sh
echo "/data/camera2_usermode.sh"
echo "reboot"
