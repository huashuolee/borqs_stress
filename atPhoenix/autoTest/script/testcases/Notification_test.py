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
        # 打开快速设置 d.swipe(100,0,100,100)

    def tearDown(self):
        u.tearDown()

    def test_switchwifi(self):
        u.recordcase(self.test_switchwifi, "Notification.Priority1")
        d.swipe(100, 0, 100, 100)
        for i in xrange(self.loop):
            if d(className="android.view.View", description=u"WLAN 连接已断开。。").exists:
                d(className="android.view.View", description=u"WLAN 连接已断开。。").click()
                time.sleep(5)
                d(className="android.view.View", description=u"WLAN 已关闭。。").click()
            else:
                d(className="android.view.View", description=u"WLAN 已关闭。。").click()
                time.sleep(5)
                d(className="android.view.View", description=u"WLAN 连接已断开。。").click()

        u.log()

    def test_onoffbt(self):
        u.recordcase(self.test_onoffbt, "Notification.Priority1")
        d.swipe(100, 0, 100, 100)
        for i in xrange(self.loop):
            if d(packageName="com.android.systemui", description=u"蓝牙关闭。", className="android.view.View").exists:
                d(packageName="com.android.systemui", description=u"蓝牙关闭。", className="android.view.View").click()
                time.sleep(5)
                d(packageName="com.android.systemui", description=u"蓝牙开启。").click()
            else:
                d(packageName="com.android.systemui", description=u"蓝牙开启。").click()
                time.sleep(5)
                d(packageName="com.android.systemui", description=u"蓝牙关闭。").click()

        u.log()

    def test_onoffaudio(self):
        u.recordcase(self.test_onoffaudio, "Notification.Priority1")
        d.swipe(100, 0, 100, 100)
        for i in xrange(self.loop):
            d(className="android.view.ViewGroup", index="1").click()
            time.sleep(2)
            d(className="android.view.ViewGroup", index="1").click()
        u.log()

    def test_onoffrotate(self):
        u.recordcase(self.test_onoffrotate, "Notification.Priority1")
        d.swipe(100, 0, 100, 100)
        for i in xrange(self.loop):
            d(className="android.view.ViewGroup", index="3").click()
            time.sleep(2)
            d(className="android.view.ViewGroup", index="3").click()
        u.log()

    def test_onoffloc(self):
        u.recordcase(self.test_onoffloc, "Notification.Priority1")
        d.swipe(100, 0, 100, 100)
        for i in xrange(self.loop):
            d(className="android.view.ViewGroup", index="4").click()
            time.sleep(2)
            d(className="android.view.ViewGroup", index="4").click()

    def test_onoffnotification(self):
        u.recordcase(self.test_onoffnotification, "Notification.Priority1")
        for i in xrange(self.loop):
            d.swipe(100, 0, 100, 100)
            time.sleep(4)
            d.press("home")

    def test_home(self):
        u.recordcase(self.test_home, "Notification.Priority1")
        d.press("home")
        d(resourceId="com.android.systemui:id/btn_witch_win_mode")
        for i in xrange(self.loop):
            d.press("home")
        d.press("back")
        d.press("home")
        d(resourceId="com.android.systemui:id/btn_witch_win_mode")
        for i in xrange(self.loop):
            d.press("home")


@unittest.skip("Skip the Priority 2 test cases")
class Priority2(unittest.TestCase):
    def setUp(self):
        self.loop = u.getloop()
        u.clog()
        u.checkScreen()
        u.setUp()

    def test_rotatenormal(self):
        for i in xrange(self.loop):
            d.press("home")
            time.sleep(2)
            d.orientation = "n"
            time.sleep(2)
            d.orientation = "l"
            time.sleep(2)
            d.orientation = "n"
            time.sleep(2)
            d.orientation = "r"
            time.sleep(2)
            d.orientation = "n"
            time.sleep(2)

    def test_rotatefullscreen(self):
        for i in xrange(self.loop):
            d.press("home")
            time.sleep(2)
            d(resourceId="com.android.systemui:id/btn_witch_win_mode").click()
            time.sleep(2)
            d.orientation = "n"
            time.sleep(2)
            d.orientation = "l"
            time.sleep(2)
            d.orientation = "n"
            time.sleep(2)
            d.orientation = "r"
            time.sleep(2)
            d.orientation = "n"
            time.sleep(2)

    def test_notification(self):
        d.swipe(100, 0, 100, 100)
        time.sleep(2)
        d.orientation = "n"
        time.sleep(2)
        d.orientation = "l"
        time.sleep(2)
        d.orientation = "n"
        time.sleep(2)
        d.orientation = "r"
        time.sleep(2)
        d.orientation = "n"
        time.sleep(2)

