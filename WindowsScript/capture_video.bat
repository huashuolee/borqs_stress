@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb  shell input keyevent 27
ping localhost -n 5 > nul
call adb shell input keyevent 27
ping localhost -n 5 > nul
if %var% lss 500 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd