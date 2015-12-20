#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss push /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/Coremark/coremark.icc12.1.107-atom-ipo-pgo.2T.exe /data/coremark
sleep 1
adb $ss shell chmod 0777 /data/coremark
sleep 1

echo "sync && echo 3 > /proc/sys/vm/drop_caches"
echo "lower of the two scores reported by the two binaries multiplied by two"
echo "Note down the Iterations/Sec result. Take at least three runs. Median of multiple runs can be used to report out."

