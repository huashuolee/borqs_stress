@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb -s Medfield82A59D6D shell am start -a android.intent.action.VIEW -d http://www.baidu.com/s?wd=%var% -f 0x10000000
ping localhost -n 12 > nul
if %var% lss 300 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd