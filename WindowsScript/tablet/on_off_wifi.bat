@echo off
echo �ֶ�����Wi-Fi settings
pause
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb shell input tap 154 188
ping localhost -n 5 > nul
call adb shell input tap 154 188
ping localhost -n 5 > nul
if %var% lss 1000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd