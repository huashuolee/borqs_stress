# -*- coding: utf-8 -*-
# case 1266
import unittest
import common.util as u
from uiautomator import device as d
import time


class lock_unlock(unittest.TestCase):
    def setUp(self):
        u.clog()

    def tearDown(self):
        pass

    # @unittest.skip("skip this test")
    def test_lock_unlock(self):
        for i in xrange(2):
            self.checkScreen()
            d.click(1380, 800)
            time.sleep(2)
            self.inputCode()
            time.sleep(2)
            d.sleep()
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
        d.sleep()
        if d.screen == "off":  # of d.screen != "on"
            d.wakeup()
            time.sleep(2)

    def inputCode(self):
        d(resourceId="com.android.systemui:id/key1").click()
        d(resourceId="com.android.systemui:id/key2").click()
        d(resourceId="com.android.systemui:id/key3").click()
        d(resourceId="com.android.systemui:id/key4").click()
        time.sleep(2)
        d(resourceId="com.android.systemui:id/key_enter").click()
