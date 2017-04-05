# -*- coding: utf-8 -*-
import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time


class Priority1(unittest.TestCase):
    def setUp(self):
        self.cmp = "com.chaozhuo.filemanager.phoenixos/com.chaozhuo.filemanager.activities.MainActivity"
        self.packageName = "com.chaozhuo.filemanager.phoenixos"
        self.className = "android.widget.LinearLayout"
        self.loop = u.getloop()
        u.clog()
        #u.checkScreen()
        u.setUp()

    def tearDown(self):
        u.tearDown()
        u.rmtestfile()

    # 1285 文管窗口打开/关闭循环100次
    def test_open_close(self):
        print "#1285 open close loop 100 times"
        u.recordcase(self.test_open_close, "FileManager.Priority1")
        for i in xrange(self.loop):
            self._launch_filemanager()
            time.sleep(2)
            #d(resourceId="android:id/mwCloseBtn").click()
            d(resourceId="android:id/close_window").click()

            time.sleep(2)
        u.log()

    def _launch_filemanager(self):
        cmp = self.cmp
        d.start_activity(component=cmp)

    def _close_filemanager(self):
        d(resourceId="android:id/close_window").click()

    def _pressBack(self):
        d(resourceId="com.chaozhuo.filemanager.phoenixos:id/go_back").click()

    # 1289 新建文件
    def test_fm_createfile(self):
        u.recordcase(self.test_fm_createfile, "FileManager.Priority1")
        for i in xrange(self.loop):
            self._launch_filemanager()
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/name_stub", text=u"文档").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/more").wait(5000)
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/more").click()
            time.sleep(2)
            d(className="android.widget.LinearLayout", index="1").wait(5000)
            d(className="android.widget.LinearLayout", index="1").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/file_name_edit").set_text("test" + str(i) + ".txt")
            time.sleep(2)
            d.press("enter")
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)
        u.log()

    # 1290 新建文件夹
    def test_fm_createfolder(self):
        u.recordcase(self.test_fm_createfolder, "FileManager.Priority1")
        for i in xrange(self.loop):
            self._launch_filemanager()
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/name_stub", text=u"文档").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/more").click()
            time.sleep(2)
            d(className="android.widget.LinearLayout", index="0").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/file_name_edit").set_text("test" + str(i))
            time.sleep(2)
            d.press("enter")
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)
        u.log()

    # 收藏栏切换
    def test_switchBfav(self):
        u.recordcase(self.test_switchBfav, "FileManager.Priority1")
        for i in xrange(self.loop):
            time.sleep(2)
            self._launch_filemanager()
            time.sleep(2)
            favlist = [u"桌面", u"下载", u"文档", u"图片", u"回收站", u"我的电脑", u"内置存储", u"网络邻居"]
            for item in favlist:
                d(resourceId="com.chaozhuo.filemanager.phoenixos:id/name_stub", text=item).click()
                time.sleep(2)
            self._close_filemanager()

        u.log()

    def test_mainWindows(self):
        u.recordcase(self.test_mainWindows, "FileManager.Priority1")
        for i in xrange(self.loop):
            time.sleep(2)
            self._launch_filemanager()
            time.sleep(2)
            mainWindowList = [u"安卓系统", u"个人空间", u"图片", u"视频", u"音乐", u"文档", u"安装包"]
            for item in mainWindowList:
                d(text=item).click()
                time.sleep(2)
                d.press("back")
                time.sleep(2)

    def test_cpuinfo(self):
        u.recordcase(self.test_cpuinfo, "FileManager.Priority1")
        for i in xrange(self.loop):
            time.sleep(2)
            self._launch_filemanager()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/status_text").click()
            time.sleep(2)
            d.press("back")
            time.sleep(2)

    #minimize the windows
    def test_min(self):
        print("this is manual test")
        pass

    # 1293 两个窗口之间拖拽移动文件100次
    def test_drag(self):
        pass

    #  1284	1	连续点击桌面文管图标20次
    def test_launch(self):
        pass

    # add network share
    def test_netshare(self):
        u.recordcase(self.test_netshare, "FileManager.Priority1")
        for i in xrange(self.loop):
            time.sleep(2)
            self._launch_filemanager()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager.phoenixos:id/icon_behind", index="3").click()
            d(text="192.168.1.").clear_text()
            d(text=u"IP或计算机名").set_text(u"192.168.1.112")
            d.press("enter")
            d.press("enter")
            d.press("enter")
            time.sleep(10)

    def test_min_max(self):
        u.recordcase(self.test_min_max, "FileManager.Priority1")
        for i in xrange(self.loop):
            time.sleep(2)
            self._launch_filemanager()
            d(resourceId="android:id/maximize_window").click()
            time.sleep(2)
            d(resourceId="android:id/maximize_window").click()
            time.sleep(2)


class Priority2(unittest.TestCase):
    def setUp(self):
        u.clog()
        u.checkScreen()
        d.click(1380, 800)
        u.setUp()

    def tearDown(self):
        u.tearDown()
