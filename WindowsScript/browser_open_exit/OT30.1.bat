@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb shell am start com.android.browser/.BrowserActivity
ping localhost -n 2 > nul
call adb shell input keyevent 82
ping localhost -n 2 > nul
call adb shell input tap 354 1834
ping localhost -n 2 > nul

if %var% lss 1000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd