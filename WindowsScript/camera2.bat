@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb -s LG-E985-0211d49f0b8f6423 shell am start com.lge.camera/.CameraApp
ping localhost -n 2 > nul
call adb -s LG-E985-0211d49f0b8f6423 shell input keyevent 27
ping localhost -n 2 > nul
call adb -s LG-E985-0211d49f0b8f6423 shell input keyevent 4
ping localhost -n 2 > nul
if %var% lss 1000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd