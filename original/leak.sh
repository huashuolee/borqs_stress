#!/bin/bash
rm -r *.mem *fd.txt
adb shell rm -r /mnt/sdcard/*fd.txt
while true;do




	adb shell procrank | grep mms | tee -a ./mms.mem
	mmspid=`cat ./mms.mem | head -n 1 | awk '{print $1}' | tr -cd [0-9]`
	adb shell <<EOF
	cd /proc/$mmspid/fd
	ls -l >> /mnt/sdcard/mmsfd.txt
	echo -e "\n" >> /mnt/sdcard/mmsfd.txt
	exit
EOF
	
	
	
	#echo -e "\n" >> ./mmsfd.txt
	oldmmsmem=`cat ./mms.mem | head -n 1 | awk '{print $5}' | tr -cd [0-9]`
	newmmsmem=`cat ./mms.mem | tail -n 1 | awk '{print $5}' | tr -cd [0-9]`
	crmem=$((newmmsmem-oldmmsmem))
	if [ $crmem -gt 3048 ];then
		echo "now!mms"
		break
	fi
	adb shell procrank | grep "com.android.phone" | tee -a ./phone.mem
	phonepid=`cat ./phone.mem | head -n 1 | awk '{print $1}' | tr -cd [0-9]`
	adb shell <<EOF1
	cd /proc/$phonepid/fd
	ls -l >> /mnt/sdcard/phonefd.txt
	echo -e "\n" >> /mnt/sdcard/phonefd.txt
	exit
EOF1
	oldpmem=`cat ./phone.mem | head -n 1 | awk '{print $5}' | tr -cd [0-9]`
	newpmem=`cat ./phone.mem | tail -n 1 | awk '{print $5}' | tr -cd [0-9]`
	crpmem=$((newpmem-oldpmem))
	if [ $crpmem -gt 3048 ];then
		echo "now!phone"
		break
	fi
	sleep 15
done
