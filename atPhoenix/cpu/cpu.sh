while true
do
    cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
    sleep 5
    echo '++++++++++++++++++++++++++'
done
