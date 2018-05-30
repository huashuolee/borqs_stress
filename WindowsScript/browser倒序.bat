@echo off
set var=600
rem ************循环开始了
:continue
ping localhost -n 6 > nul
echo 第%var%次循环
call adb -s Medfield82A59D6D shell am start -a android.intent.action.VIEW -d http://www.baidu.com/s?wd=%var% -f 0x10000000 
set /a var-=1
if %var% gtr 0 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
cmd