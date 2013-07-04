#! /bin/bash
mkdir meminfo
touch ./meminfo/vmstatm-output.log
adb pull /data/system/packages.list ./meminfo/
n=1
while true; do
export pkg=`cat ./meminfo/packages.list | awk 'NR=='$n' {print $1}'`
export pkgnum=`wc ./meminfo/packages.list |awk 'NR== 1 {print $1}'`
adb shell monkey -s 123 -p $pkg 3

echo "***********************************************************************************$pkg" >> ./meminfo/vmstatm-output.log
adb shell date >> ./meminfo/vmstatm-output.log
adb shell vmstatm >> ./meminfo/vmstatm-output.log
adb shell procrank >> ./meminfo/vmstatm-output.log 
sleep 10
echo "" >> ./meminfo/vmstatm-output.log

n=$((n+1))
if [ $n -gt $pkgnum ]; then
n=1
sleep 600
echo "Already finish a loop" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! >> ./meminfo/vmstatm-output.log
fi
done


