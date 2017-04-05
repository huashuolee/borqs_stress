# -*- coding: utf-8 -*-
# case 1289
import os
import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time

"""
issues:
1. adb always offline
"""
class fm_createfile(unittest.TestCase):
    def setUp(self):
        u.clog()
        u.checkScreen()
        d.click(1380, 800)
        u.setUp()

    def tearDown(self):
        u.tearDown()

    def test_fm_createfile(self):
        for i in xrange(100):
            self._launch_apps()
            d(resourceId="com.chaozhuo.filemanager:id/text_navigation_child",text=u"文档").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/more").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/item_title", text=u"新建文件").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.filemanager:id/file_name_edit").set_text("test"+str(i)+".txt")
            time.sleep(2)
            d.press("enter")
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)





    def _launch_apps(self):
        cmp = "com.chaozhuo.filemanager/.activities.MainActivity"
        d.start_activity(component=cmp)
