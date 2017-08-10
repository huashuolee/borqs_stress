#!/bin/bash
#This script is use for describle CPU Hard Memery Utilization
total=0
idle=0
system=0
user=0
nice=0
mem=0
vmexec=/usr/bin/vmstat
which sar > /dev/null 2>&1
if [ $? -ne 0 ]
then
      ver=`vmstat -V | awk '{printf $3}'`
        nice=0
          temp=`vmstat 1 3 |tail -1`
            user=`echo $temp |awk '{printf("%s\n",$13)}'`
              system=`echo $temp |awk '{printf("%s\n",$14)}'`
                idle=`echo $temp |awk '{printf("%s\n",$15)}'`
                  total=`echo|awk '{print (c1+c2)}' c1=$system c2=$user`
              fi
              echo "#CPU Utilization#"
              echo "Total CPU  is already use: $total"
              echo "CPU user   is already use: $user"
              echo "CPU system is already use: $system"
              echo "CPU nice   is already use: $nice"
              echo "CPU idle   is already use: $idle"
              echo
              root_use=$(df -lh | awk 'NR==2' | awk '{print $5}')
              dev_use=$(df -lh | awk 'NR==3' | awk '{print $5}')
              dev_shm_use=$(df -lh | awk 'NR==4' | awk '{print $5}')
              echo "#Hard Utilization#"
              echo "/        is already use: $root_use"
              echo "/dev     is already use: $dev_use"
              echo "/dev/shm is already use: $dev_shm_use"
              echo
              memery_used=$(free | awk 'NR==2' | awk '{print $3}')
              memery_all=$(free | awk 'NR==2' | awk '{print $2}')
              memery_percent=$(echo "scale=4;$memery_used / $memery_all" | bc)
              percent_part1=$(echo $memery_percent | cut -c 2-3)
              percent_part2=$(echo $memery_percent | cut -c 4-5)
              echo "#Memery Utilization#"
              echo "system memery is already use: $percent_part1.$percent_part2%"
              swap_used=$(free | awk 'NR==4' | awk '{print $3}')
              swap_all=$(free | awk 'NR==4' | awk '{print $2}')
              swap_percent=$(echo "scale=4;$swap_used / $swap_all" | bc)
              swap_part1=$(echo $swap_percent | cut -c 2-3)
              swap_part2=$(echo $swap_percent | cut -c 4-5)
              echo "swap   memery is already use: $swap_part1.$swap_part2%"
              echo
