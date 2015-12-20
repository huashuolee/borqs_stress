#!/bin/bash
adb shell busybox mkdir -p /mnt/sdcard/data/logs
adb shell configure_trace_modem -d -t1
adb shell activate_trace_modem -on -sd1 -p
echo "Please reboot manually, press a key to continue."
read anyelse
exit 0
