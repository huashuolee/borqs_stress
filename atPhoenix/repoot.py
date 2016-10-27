for (( n=1; n<=1000; n++ ))
    do
        adb wait-for-device reboot
        echo $n
	sleep 30
    done
