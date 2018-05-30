@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
call adb -s LG-E985-054ba0cd15906623 shell input tap 415 869
ping localhost -n 2 > nul
call adb -s LG-E985-054ba0cd15906623 shell input keyevent 82
ping localhost -n 2 > nul
call adb -s LG-E985-054ba0cd15906623 shell input tap 467 1144
ping localhost -n 2 > nul
call adb -s LG-E985-054ba0cd15906623 shell input tap 787 1171 
ping localhost -n 2 > nul
if %var% lss 1000 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd