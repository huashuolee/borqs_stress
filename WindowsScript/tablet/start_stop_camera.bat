@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
call adb shell am start com.android.gallery3d/com.android.camera.CameraLauncher
ping localhost -n 2 > null
call adb shell input keyevent 4
ping localhost -n 2 > null
if %var% lss 1000 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd
