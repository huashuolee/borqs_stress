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
call adb shell input tap 733 1693
ping localhost -n 2 > nul
call adb shell input tap 411 448
ping localhost -n 2 > nul
call adb shell input tap 900 300
ping localhost -n 2 > nul
call adb shell input tap 722 1191
ping localhost -n 2 > nul
call adb shell input keyevent 4
ping localhost -n 2 > nul
call adb shell input keyevent 4
ping localhost -n 2 > nul
call adb shell input tap 50 234
ping localhost -n 10 > nul
call adb shell input keyevent 82
ping localhost -n 2 > nul
call adb shell input tap 354 1834
ping localhost -n 5 > nul

if %var% lss 1000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd