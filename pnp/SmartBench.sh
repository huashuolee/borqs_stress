#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/SmartBench/smartbench.2012-1.apk

echo "Result shows two bars, one green for 'productivity index' and one red for 'games index'"
