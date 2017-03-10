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

    def test_fm_onclick(self):
        for i in xrange(20):
            d(resourceId="com.chaozhuo.filemanager:id/icon_img").click()
            time.sleep(2)
            d(resourceId="android:id/mwMinBtn").click()
            time.sleep(2)
