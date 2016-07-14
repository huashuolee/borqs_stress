#!/bin/bash
while true;
do
adb shell free -m |tee -a meminfo.log;
sleep 1;
done

