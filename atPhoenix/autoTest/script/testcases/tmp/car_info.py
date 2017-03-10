# -*- coding: utf-8 -*-
from uiautomatorplug.android import device as d
import unittest
import time
import common.util as u


@unittest.skip
class CarInfo(unittest.TestCase):
    def setUp(self):
        d.start_activity(component='com.ucs/com.app.activity.index.ActivitySplash')
        time.sleep(5)
        d(resourceId="com.ucs:id/desk_tab_carinfo").click()
        time.sleep(2)
        self.regesiterWatcher()

    def regesiterWatcher(self):
        d.watchers.reset()
        d.watchers.remove()
        d.watcher(u"fc").when(textContains=u"很抱歉").click(text=u"确定")

    def tearDown(self):
        for i in range(5):
            d.press.back()
        self.checkSystemWatchers()

    def checkSystemWatchers(self):
        self.assertFalse(d.watcher("fc").triggered, "APP force close")

    def test_car_info_als(self):
        try:
            d(resourceId="com.ucs:id/desk_tab_carinfo").click()
        except:
            raise Exception

        d(resourceId="com.ucs:id/already_sailing").click()
        time.sleep(2)
        if not d(resourceId="com.ucs:id/search_result").exists:
            assert False
        for i in range(10):
            d.swipe(640, 1076, 640, 420)
            time.sleep(1)
        time.sleep(5)
        d.click(640, 1076)
        time.sleep(10)
        self.assertFalse(d(resourceId="com.ucs:id/goto_share").exists, "Test finished")
        time.sleep(2)
        d.press.back()
        d(resourceId="com.uscs.").click


class OtherTest(unittest.TestCase):
    def setUp(self):
        # u.clog()
        pass

    def tearDown(self):
        pass

    # @unittest.skip("skip this test")
    def test_true(self):
        # folder = getattr(self.test_true, "__name__")
        # 把case名写进testresult/folder文件下,方便其他方法读取方法名
        u.recordcase(self.test_true, "OtherTest")
        time.sleep(30)
        assert True
        u.log()

    def test_false(self):
        u.recordcase(self.test_false, "OtherTest")
        time.sleep(10)
        try:
            assert True
        finally:
            u.log()
