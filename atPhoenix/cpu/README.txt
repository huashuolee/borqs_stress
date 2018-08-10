adb root
adb push cpu.sh /sdcard/cpu.sh
adb push get_fps.sh /sdcard/get_fps.sh
adb push temp.sh /sdcard/temp.sh

获取cpu频率
adb shell sh /sdcard/cpu.sh
获取帧率
adb shell sh /sdcard/get_fps.sh
获取温度
adb shell sh /sdcard/temp.sh
