# -*- coding: utf-8 -*-
# case 1284
import os
import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time

"""
issues:
1. adb always offline
"""
class fm_open_close(unittest.TestCase):
    def setUp(self):
        u.clog()
        u.checkScreen()
        d.click(1380, 800)
        u.setUp()

    def tearDown(self):
        u.tearDown()

    # @unittest.skip("skip this test")
    def test_open_close(self):
        for i in xrange(100):
            self._launch_apps()
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)


    def _launch_apps(self):
        cmp = "com.chaozhuo.filemanager/.activities.MainActivity"
        d.start_activity(component=cmp)
