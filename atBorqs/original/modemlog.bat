@echo off
echo "Now, enable Modem log, please make sure SD card is OK on DUT. Press any key to continue.."
pause
adb shell busybox mkdir -p /mnt/sdcard/data/logs
adb shell configure_trace_modem -d -t1
adb shell activate_trace_modem -on -sd1 -p
echo "Press any key to power off.."
pause
adb shell poweroff -f 
