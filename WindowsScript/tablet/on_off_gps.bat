@echo off
echo 手动进入Location accesss

echo Access to my location is OFF
pause
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
call adb shell input tap 641 181
ping localhost -n 2 > nul
call adb shell input tap 500 560
ping localhost -n 2 > nul
call adb shell input tap 641 181
ping localhost -n 2 > nul
if %var% lss 1000 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd