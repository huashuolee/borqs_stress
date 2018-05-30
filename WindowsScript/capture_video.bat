@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
call adb  shell input keyevent 27
ping localhost -n 5 > nul
call adb shell input keyevent 27
ping localhost -n 5 > nul
if %var% lss 500 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd