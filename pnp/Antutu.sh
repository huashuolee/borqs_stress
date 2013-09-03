#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/AnTuTu/AnTuTu_Benchmark_2_9_4.apk

