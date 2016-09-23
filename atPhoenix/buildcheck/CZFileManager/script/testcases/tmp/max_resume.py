# -*- coding: utf-8 -*-
# case 1272
import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time


class max_resume(unittest.TestCase):
    def setUp(self):
        u.clog()
        self.checkScreen()
        d.click(1380, 800)
        self.inputCode()

        time.sleep(2)
        for i in xrange(4):
            d.press("back")
        self._launch_filemanager()

    def tearDown(self):
        pass

    # @unittest.skip("skip this test")
    def test_max_resume(self):
        for i in xrange(2):
            d(resourceId="android:id/mwMaxBtn").click()
            time.sleep(2)
            d(resourceId="android:id/mwMaxBtn").click()
            time.sleep(2)

       # u.log()

    @unittest.skip("skip this test")
    def test_false(self):
        u.recordcase(self.test_false, "OtherTest")
        time.sleep(10)
        try:
            assert True
        finally:
            u.log()

    def checkScreen(self):
        d.screen.off()
        time.sleep(2)
        if d.screen == "off":  # of d.screen != "on"
            d.wakeup()
            time.sleep(2)



    def _launch_filemanager(self):
        cmp="com.chaozhuo.filemanager/.activities.MainActivity"
        d.start_activity(component=cmp)

