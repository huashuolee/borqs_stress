@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
copy t.jpg %var%.jpg
ping localhost -n 1 > nul

if %var% lss 1500 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd