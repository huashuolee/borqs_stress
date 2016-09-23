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


class util(object):

    def __init__(self):
        super(util, self).__init__()


    def clog(self):
        os.system("adb logcat -c")

    def log(self):
        cmd = 'adb shell logcat -v time -d  '
        # 以时间命名 2016-04-16-05
        line = self.path
        # 以caseName命名 OtherTest.test_fail
        os.makedirs("testresult" + os.sep + self.path + os.sep + "log" + os.sep + self.folder)
        # record_log="testresult/2016-04-16-05/OtherTest.test_fail/2010xxx.log"
        record_log = "testresult" + os.sep + self.path + os.sep + "log" + os.sep + self.folder + os.sep + time.strftime(
            "%Y%m%d%H%M%S",
            time.localtime(
                time.time())) + ".log"
        with open(record_log, 'w') as f:
            p = subprocess.Popen(cmd, stdout=f, stderr=subprocess.PIPE, shell=True)

    def result_path(self):
        # under testresult, mkdir 2016-04-16-05
        # 定义成全局的？
        iso_time_format = '%Y-%m-%d-%H-%M'
        self.path = time.strftime(iso_time_format, time.localtime(time.time()))
        if os.path.exists("testresult" + os.sep + self.path):
            shutil.rmtree("testresult" + os.sep + self.path)
        time.sleep(2)
        os.mkdir("testresult" + os.sep + self.path)
        return self.path

    def recordcase(self, caseName, className):

        self.folder = getattr(caseName, "__name__")
