@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb shell input tap 850 420
ping localhost -n 2 > nul
call adb shell input tap 120 700
ping localhost -n 10 > nul
if %var% lss 100000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd
