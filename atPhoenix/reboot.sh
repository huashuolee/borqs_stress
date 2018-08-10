for (( n=1; n<=1000; n++ ))
    do
        adb wait-for-device reboot
        echo `date` "$n"
	sleep 30
    done
