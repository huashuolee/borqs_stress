@echo off
set var=1000
rem ************ѭ����ʼ��
:continue
ping localhost -n 10 > nul
echo ��%var%��ѭ��
call adb -s MedfieldFDB9BD36 shell input keyevent 27
set /a var-=1
if %var% gtr 0 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause