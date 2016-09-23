# -*- coding: utf-8 -*-

from uiautomatorplug.android import device as d
import os
import time
import shutil
import subprocess


def registerSysWatchers():
    d.watchers.reset()
    d.watchers.remove()
    d.watcher("IGNORE_ANR").when(textContains='无响应').click(text='确定')
    d.watcher("IGNORE_CRASH").when(textContains='停止运行').click(text='确定')
    d.watcher("IGNORE_POPWINDOW_WEIBO").when(textContains='给我们评分').click(text='不了，谢谢')
    d.watcher("IGNORE_DRAFT").when(textContains='是否保存草稿').click(text='不保存草稿')
    d.watcher("IGNORE_LOCATION").when(textContains='位置信息').click(text='拒绝')
    d.watcher("IGNORE_WLAN").when(textContains='WLAN').click(text='确定')
    d.watcher("IGNORE_NAVIGATION").when(textContains='离线地图').click(text='暂不需要')
    d.watcher(u"fc").when(textContains=u"很抱歉").click(text=u"确定")


def checkSystemWatchers():
    if d.watcher("IGNORE_ANR").triggered:
        raise Exception('AUTO_FC_WHEN_ANR')
    if d.watcher("IGNORE_CRASH").triggered:
        raise Exception('IGNORE_CRASH')
    if d.watcher(u"fc").triggered:
        raise Exception("Force close occurs")
    d.watchers.reset()
    d.watchers.remove()


def setUp():
    d.press("home")
    d.press("home")
    for i in xrange(9):
        d.press("back")
    registerSysWatchers()


def tearDown():
    for i in xrange(4):
        d.press("back")
    checkSystemWatchers()
    time.sleep(2)


def getloop():
    #with open("testresult" + os.sep + "loop", "r") as f:
    #    loop = f.readline()
    return 1


def checkScreen():
    d.server.jsonrpc.sleep()
    if d.screen == "off":  # of d.screen != "on"
        d.wakeup()
        time.sleep(2)
        d.press("menu")


def inputCode():
    d(resourceId="com.android.systemui:id/key1").click()
    d(resourceId="com.android.systemui:id/key2").click()
    d(resourceId="com.android.systemui:id/key3").click()
    d(resourceId="com.android.systemui:id/key4").click()
    time.sleep(2)
    d(resourceId="com.android.systemui:id/key_enter").click()


def clog():
    os.system("adb logcat -c")


def log():
    cmd = 'adb shell logcat -v time -d  '
    # 以时间命名
    with open("testresult" + os.sep + "file_path", "r") as f:
        line = f.readline()
    # 以caseName命名
    with open("testresult" + os.sep + "folder", "r") as f:
        casedir = f.read()
    os.makedirs("testresult" + os.sep + line + os.sep + "log" + os.sep + casedir)
    # record_log="testresult/2016-04-16-05/OtherTest.test_fail/2010xxx.log"
    record_log = "testresult" + os.sep + line + os.sep + "log" + os.sep + casedir + os.sep + time.strftime(
        "%Y%m%d%H%M%S",
        time.localtime(
            time.time())) + ".log"
    with open(record_log, 'w') as f:
        p = subprocess.Popen(cmd, stdout=f, stderr=subprocess.PIPE, shell=True)


def result_path():
    # under testresult, mkdir 2016-04-16-05
    iso_time_format = '%Y-%m-%d-%H-%M'
    path = time.strftime(iso_time_format, time.localtime(time.time()))

    if os.path.exists("testresult" + os.sep + path):
        shutil.rmtree("testresult" + os.sep + path)
    time.sleep(2)
    os.mkdir("testresult" + os.sep + path)
    with open("testresult" + os.sep + "file_path", "w") as f:
        f.write(path)
    return path


def recordcase(caseName, className):
    folder = getattr(caseName, "__name__")
    with open("testresult" + os.sep + "folder", 'w') as f:
        f.write(className + "." + folder)


def rmtestfile():
    cmd = "adb shell rm -rf /sdcard/Documents/*"
    os.system(cmd)
