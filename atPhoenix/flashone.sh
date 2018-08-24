#!/bin/bash

function flash_bp()
{
    BP_IMAGE="xbl:xbl.img tz:tz.img rpm:rpm.img hyp:hyp.img pmic:pmic.img keymaster:keymaster.img cmnlib:cmnlib.img cmnlib64:cmnlib64.img mdtpsecapp:mdtpsecapp.img mdtp:mdtp.img modem:modem.img dsp:dsp.img abl:abl.img bluetooth:bluetooth.img devcfg:devcfg.img"
    for var in $BP_IMAGE
        do
            echo $var
            label_a=$PART_PATH`echo $var |cut -d \: -f 1`_a
            label_b=$PART_PATH`echo $var |cut -d \: -f 1`_b
            filename=$PART_PATH`echo $var |cut -d \: -f 2`
            fastboot flash $label_a $1"/"$filename
            fastboot flash $label_b $1"/"$filename
        done

}

function flash_nonab()
{
    IMAGE="splash:splash.img userdata:userdata.img"
    for var in $IMAGE
        do
            echo $var
            label=$PART_PATH`echo $var |cut -d \: -f 1`
            filename=$PART_PATH`echo $var |cut -d \: -f 2`
            fastboot flash $label $1"/"$filename
        done
}

function flash_main()
{
    MAIN_IMAGE="boot:boot.img vendor:vendor.img system:system.img"
    for var in $MAIN_IMAGE
        do
            echo $var
            label_a=$PART_PATH`echo $var |cut -d \: -f 1`_a
            label_b=$PART_PATH`echo $var |cut -d \: -f 1`_b
            filename=$PART_PATH`echo $var |cut -d \: -f 2`
            fastboot flash $label_a $1"/"$filename
            fastboot flash $label_b $1"/"$filename
        done
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
    echo "flash bp files, yes or no? "
    read choice
    if [ "$choice" == "yes" ];then
        flash_bp $1
        flash_nonab $1
    fi
    flash_main $1
fi
