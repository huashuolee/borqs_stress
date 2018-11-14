#!/bin/bash
echo pull all radio file from device
adb wait-for-devices
adb devices
sleep 3

adb root
adb remount
PART_PATH=/dev/block/bootdevice/by-name/
PART_NAME="xbl:xbl.elf modem:NON-HLOS.bin bluetooth:BTFM.bin tz:tz.mbn rpm:rpm.mbn hyp:hyp.mbn pmic:pmic.elf dsp:adspso.bin devcfg:devcfg.mbn  cmnlib:cmnlib.mbn cmnlib64:cmnlib64.mbn keymaster:keymaster64.mbn mdtpsecapp:mdtpsecapp.mbn  mdtp:mdtp.img  abl:abl.elf devcfg:devcfg.mbn   boot:boot.img system:system.img vendor:vendor.img"

#PART_NAME_BAK="sbl1bak:sbl1.mbn.bak  tzbak:tz.mbn.bak rpmbak:rpm.mbn.bak abootbak:emmc_appsboot.mbn.bak  devcfgbak:devcfg.mbn.bak  lksecappbak:lksecapp.mbn.bak cmnlibbak:cmnlib.mbn.bak cmnlib64bak:cmnlib64.mbn.bak keymasterbak:keymaster.mbn.bak"

PART_NAME_MAIN="boot:boot.img system:system.img vendor:vendor.img "

###
###
echo "pull radio_A files"

for var in $PART_NAME
do
echo $var
var_source=$PART_PATH`echo $var |cut -d \: -f 1`_a
var_dest=`echo $var |cut -d \: -f 2`_a
echo $var_source $var_dest
adb pull $var_source _A/$var_dest
done 

###
###
###
echo "pull radio B files"

for var in $PART_NAME
do
echo $var
var_source=$PART_PATH`echo $var |cut -d \: -f 1`_b
var_dest=`echo $var |cut -d \: -f 2`_b
echo $var_source $var_dest
adb pull $var_source _B/$var_dest
done 
