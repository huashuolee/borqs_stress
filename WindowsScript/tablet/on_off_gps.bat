@echo off
echo �ֶ�����Location accesss

echo Access to my location is OFF
pause
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb shell input tap 641 181
ping localhost -n 2 > nul
call adb shell input tap 500 560
ping localhost -n 2 > nul
call adb shell input tap 641 181
ping localhost -n 2 > nul
if %var% lss 1000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd