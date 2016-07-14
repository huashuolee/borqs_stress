@echo off
call adb shell am start com.android.gallery3d/com.android.camera.CameraLauncher
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环

ping localhost -n 5 > nul
call adb shell input tap 630 940
ping localhost -n 4 > nul
call adb shell input tap 310 400
ping localhost -n 4 > nul
if %var% lss 1000 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd