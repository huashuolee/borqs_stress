@echo off
set var=1000
rem ************循环开始了
:continue
ping localhost -n 10 > nul
echo 第%var%次循环
call adb -s MedfieldFDB9BD36 shell input keyevent 27
set /a var-=1
if %var% gtr 0 goto continue
rem ************循环结束了
echo 循环执行完毕
pause