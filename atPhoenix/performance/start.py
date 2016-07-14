# -*- coding: utf-8 -*-

import os, sys
import subprocess

import time

cmplist = []
cmplist.append("com.chaozhuo.filemanager/.activities.MainActivity")
cmplist.append("com.chaozhuo.browser/org.chromium.chrome.shell.ChaoZhuoActivity")
cmplist.append("com.tencent.android.qqdownloader/com.tencent.assistant.activity.SplashActivity")
cmplist.append("com.chaozhuo.voicerecorder/.MainActivity")
cmplist.append("com.android.calendar/.AllInOneActivity")


class Performance():
    def __init__(self):
        cmd = 'adb logcat -c'
        os.system(cmd)

    def hotlaunch(self):
        os.system("rm log.csv")
        for item in cmplist:
            try:
                os.system("adb shell logcat -c;sleep 1")
                cmd = 'adb shell am start ' + item
                os.system(cmd)
                time.sleep(10)
                cmd = 'adb shell logcat -v time -d |grep Displayed'
                p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
                log = p.communicate()
                print log
                with open("log.csv", "aw") as f:
                    f.write(str(log[0].split(":")[-2]).split(" ")[2] + " " + str(log[0].split(":")[-1]))
                #f.write(str(log[0].split(":")[-1]))
                for i in xrange(10):
                    os.system("adb shell input keyevent 4")
            except:
                print "App doesn't launch in 2s"
            finally:
                os.system("adb shell input keyevent 4")
                os.system("adb shell input keyevent 4")
                os.system("adb shell input keyevent 4")

if __name__ == "__main__":
    Performance().hotlaunch()
