@echo off
set var=0
rem ************ѭ����ʼ��
:continue
set /a var+=1
echo ��%var%��ѭ��
call adb shell am start com.android.gallery3d/com.android.camera.CameraLauncher
ping localhost -n 2 > null
call adb shell input keyevent 4
ping localhost -n 2 > null
if %var% lss 1000 goto continue
rem ************ѭ��������
echo ѭ��ִ�����
pause
cmd
