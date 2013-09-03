#!/bin/bash
ss=""
[[ -n $1 ]] && ss="-s $1"
adb $ss install /media/74D6761FD675E1B2/work/Tools/Pnp/Anzhen2_PerfKPI/Quadrant2.1.1/quadrant.ui.professional-2.1.1.apk

echo "Force GPU Rendering option in Settings"
