@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
copy t.jpg %var%.jpg
ping localhost -n 1 > nul

if %var% lss 1500 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd