@echo off
echo "Press a key to start catching logs (c:\logs), the logs before will be deleted."
pause
del c:\logs
mkdir c:\logs
echo "Catching logs..."
adb pull /data/logs/ c:\logs
adb pull /data/logs/panic/ c:\logs
adb pull /data/anr/ c:\logs
adb pull /data/system/dropbox/ c:\logs
rem echo "Catching adb logs..."
rem adb pull /data/adb c:\logs
rem adb pull /data/adb_fork c:\logs
rem adb pull /data/usb_dmesg.txt c:\logs
echo "Catching system state, this need ten or more sencond.."
adb shell dumpstate > c:\logs\dumpstate.txt
echo "Catching network logs..."
adb shell busybox ifconfig -a > c:\logs\ifconfig.txt
adb shell busybox route -n > c:\logs\route.txt
adb shell lsmod > c:\logs\lsmod.txt
adb shell cat /proc/mounts > c:\logs\mount.txt
echo "Over, logs stored at c:\logs"
pause
