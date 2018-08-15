#!/bin/bash

function flash()
{
fastboot flash system_a $1"/system.img"
fastboot flash system_b $1"/system.img"
fastboot flash boot_a $1"/boot.img"
fastboot flash boot_b $1"/boot.img"
fastboot flash vendor_a $1"/vendor.img"
fastboot flash vendor_b $1"/vendor.img"
echo "erase userdata, yes or no ? "
read choice 
if [ "$choice" == "yes" ];then
    erase
fi
fastboot reboot
}

function erase()
{
fastboot erase misc
fastboot erase userdata
}

if [ -z $1 ];then
    echo "Usage: flashone.sh path(e.g.flashone.sh /home/build/108/)"
else
    echo "start to flash:"
    flash $1
fi

