@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
copy �����\LG-E985\Internal storage\1.vcf �����\LG-E985\Internal storage\1%var%.vcf
ping localhost -n 1 > nul

if %var% lss 1000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd