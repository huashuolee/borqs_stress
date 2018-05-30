@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%次循环
call adb -s Medfield61D15A91 shell am start -a android.intent.action.CALL -d tel:18601131645
ping localhost -n 30 > nul
if %var% lss 100 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd