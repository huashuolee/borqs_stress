BP_IMAGE="xbl:xbl.img tz:tz.img rpm:rpm.img hyp:hyp.img pmic:pmic.img keymaster:keymaster.img cmnlib:cmnlib.img cmnlib64:cmnlib64.img mdtpsecapp:mdtpsecapp.img mdtp:mdtp.img modem:modem.img dsp:dsp.img abl:abl.img splash:splash.img bluetooth:bluetooth.img devcfg:devcfg.img userdata:userdata.img"

for var in $BP_IMAGE
    do 
        echo $var
        label=$PART_PATH`echo $var |cut -d \: -f 1`_a
        filename=$PART_PATH`echo $var |cut -d \: -f 2`
        echo $label 
        echo $filename
    done
