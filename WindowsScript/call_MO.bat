@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb -s Medfield61D15A91 shell am start -a android.intent.action.CALL -d tel:18601131645
ping localhost -n 30 > nul
if %var% lss 100 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd