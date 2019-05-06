#!/system/bin/sh

function backup()
{
    mkdir -p /dev/snd/backup
    cd /dev/snd/
    for i in `ls pcmC0*`;do cp /dev/snd/$i /dev/snd/backup/$i ; done
}

function switch_hdmi()
{
    rm /dev/snd/pcmC0D10p
    ln -s /dev/snd/pcmC0D3p /dev/snd/pcmC0D10p
    echo "hdmi"


}

function switch_speaker()
{
    rm /dev/snd/pcmC0D10p
    ln -s /dev/snd/pcmC0D0p /dev/snd/pcmC0D10p

    echo "speaker"

}



if [ ! -d "/dev/snd/backup" ];then
    backup
fi

if [ "$1" == "hdmi" ];then
    switch_hdmi
fi

if [ "$1" == "speaker" ];then
    switch_speaker
fi

