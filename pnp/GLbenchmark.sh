#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/GLBenchmark2.5.1/GLBenchmark_2_5_1_b306a5_Android_Corporate_Package.apk
sleep 1
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/GLBenchMark2.1.2/GLBenchmark_2.1.2_EF23DA_Android_Binary_Package.apk
