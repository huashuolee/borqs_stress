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

    def _launch_filemanager(self):
        cmp = self.cmp
        d.start_activity(component=cmp)

    def _close_filemanager(self):
        d(resourceId="android:id/close_window").click()

    def _pressBack(self):
        d(resourceId="com.chaozhuo.filemanager.phoenixos:id/go_back").click()





    def test_min_max(self):
        u.recordcase(self.test_min_max, "FileManager.Priority1")
        for i in xrange(self.loop):
            time.sleep(2)
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
