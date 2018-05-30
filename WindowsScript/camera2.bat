@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
call adb -s LG-E985-0211d49f0b8f6423 shell am start com.lge.camera/.CameraApp
ping localhost -n 2 > nul
call adb -s LG-E985-0211d49f0b8f6423 shell input keyevent 27
ping localhost -n 2 > nul
call adb -s LG-E985-0211d49f0b8f6423 shell input keyevent 4
ping localhost -n 2 > nul
if %var% lss 1000 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd