@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
call adb shell input tap 850 420
ping localhost -n 2 > nul
call adb shell input tap 120 700
ping localhost -n 10 > nul
if %var% lss 100000 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd
