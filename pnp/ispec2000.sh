#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss "wait-for-device" root
adb $ss "wait-for-device" remount
adb $ss "wait-for-device" devices
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/ISPEC2000/spec_icc11.tar.gz /data/
sleep 1
adb $ss shell busybox tar -xzvf /data/spec_icc11.tar.gz -C /data/
sleep 1
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/ISPEC2000/spec/run-all.sh.sh /data/spec/
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/ISPEC2000/spec/run-all-specrate_2t_cpu_affinity.sh /data/spec/
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/ISPEC2000/spec/output_specInt_rate_2t.sh /data/spec/
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/ISPEC2000/spec/outputNew.sh /data/spec
sleep 1
adb $ss shell busybox find /data/spec/ -name *ic11* |busybox xargs ls -l
adb $ss shell busybox find /data/spec/ -name *ic11* |busybox xargs chmod 0777
sleep 1
echo "sync && echo 3 > /proc/sys/vm/drop_caches"
echo "./run-all.sh(speed) ./outputNew.sh"
echo "/run-all-specrate_2t_cpu_affinity.sh 0x4 0x8(HT)/output_specInt_rate_2t.sh"
echo "/run-all-specrate_2t_cpu_affinity.sh 0x1 0x4(DC)/output_specInt_rate_2t.sh"

