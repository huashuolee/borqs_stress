#!/bin/bash

function flash()
{
fastboot flash system_a $1"/system.img"
fastboot flash system_b $1"/system.img"
fastboot flash boot_a $1"/boot.img"
fastboot flash boot_b $1"/boot.img"
fastboot flash vendor_a $1"/vendor.img"
fastboot flash vendor_b $1"/vendor.img"
echo "erase userdata?"
fastboot erase userdata
fastboot erase misc
fastboot reboot
}

if [ -z $1 ];then
    echo "Usage: flashone.sh path(e.g.flashone.sh /home/build/108/)"
else
    echo "start to flash:"
    flash $1
fi

