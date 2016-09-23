# -*- coding: utf-8 -*-
import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time


class Priority1(unittest.TestCase):
    def setUp(self):
        self.loop = u.getloop()
        u.clog()
        u.checkScreen()
        u.setUp()

    def tearDown(self):
        u.tearDown()
        u.rmtestfile()

    # 1285 文管窗口打开/关闭循环100次
    def test_open_close(self):
        u.recordcase(self.test_open_close, "FileManager.Priority1")
        for i in xrange(self.loop):
            self._launch_filemanager()
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)
        u.log()

    def _launch_filemanager(self):
        cmp = "com.chaozhuo.filemanager/.activities.MainActivity"
        d.start_activity(component=cmp)

    # 1287 1288 复制粘贴100次
    def test_fm_copy(self):
        u.recordcase(self.test_fm_copy, "FileManager.Priority1")
        self._launch_filemanager()
        d(resourceId="com.chaozhuo.filemanager:id/text_navigation_child", text=u"文档").click()
        time.sleep(2)
        d(resourceId="com.chaozhuo.filemanager:id/more").wait(5000)
        d(resourceId="com.chaozhuo.filemanager:id/more").click()
        time.sleep(2)
        d(resourceId="com.chaozhuo.filemanager:id/item_title", text=u"新建文件").click()
        time.sleep(2)
        d(resourceId="com.chaozhuo.filemanager:id/file_name_edit").set_text("test.txt")
        time.sleep(2)
        d.press("enter")
        time.sleep(2)
        d(resourceId="com.chaozhuo.filemanager:id/node_list").click()
        time.sleep(2)
        d(resourceId="com.chaozhuo.filemanager:id/more").click()
        time.sleep(2)
        d(resourceId="com.chaozhuo.filemanager:id/item_title", text=u"全选").click()
        time.sleep(2)
        d(resourceId="com.chaozhuo.filemanager:id/copy", text=u"复制").click()
        time.sleep(2)
        for i in xrange(self.loop):
            d(resourceId="com.chaozhuo.filemanager:id/more").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/item_title", text=u"粘贴").click()
            time.sleep(2)
        u.log()

    # 1289 新建文件 100次
    def test_fm_createfile(self):
        u.recordcase(self.test_fm_createfile, "FileManager.Priority1")
        for i in xrange(self.loop):
            self._launch_filemanager()
            d(resourceId="com.chaozhuo.filemanager:id/text_navigation_child", text=u"文档").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/more").wait(5000)
            d(resourceId="com.chaozhuo.filemanager:id/more").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/item_title", text=u"新建文件").wait(5000)
            d(resourceId="com.chaozhuo.filemanager:id/item_title", text=u"新建文件").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/file_name_edit").set_text("test" + str(i) + ".txt")
            time.sleep(2)
            d.press("enter")
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)
        u.log()

    # 1290 新建文件夹 100次
    def test_fm_createfolder(self):
        u.recordcase(self.test_fm_createfolder, "FileManager.Priority1")
        for i in xrange(self.loop):
            self._launch_filemanager()
            d(resourceId="com.chaozhuo.filemanager:id/text_navigation_child", text=u"文档").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/more").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/item_title", text=u"新建文件夹").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/file_name_edit").set_text("test" + str(i))
            time.sleep(2)
            d.press("enter")
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)
        u.log()



