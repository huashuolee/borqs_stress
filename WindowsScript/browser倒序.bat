@echo off
set var=600
rem ************ѭ����ʼ��
:continue
ping localhost -n 6 > nul
echo ��%var%��ѭ��
call adb -s Medfield82A59D6D shell am start -a android.intent.action.VIEW -d http://www.baidu.com/s?wd=%var% -f 0x10000000 
set /a var-=1
if %var% gtr 0 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd