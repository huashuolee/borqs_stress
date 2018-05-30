@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
copy 计算机\LG-E985\Internal storage\1.vcf 计算机\LG-E985\Internal storage\1%var%.vcf
ping localhost -n 1 > nul

if %var% lss 1000 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd