# -*- coding: utf-8 -*-

import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time


class Priority1(unittest.TestCase):
    url_list = []
    url_list.append("www.baidu.com")
    url_list.append("www.163.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")
    url_list.append("www.phoenixos.com")

    def setUp(self):
        self.loop = u.getloop()
        u.clog()
        u.checkScreen()
        u.setUp()
        # 打开快速设置 d.swipe(100,0,100,100)

    def tearDown(self):
        u.tearDown()

    def test_switchtab(self):
        u.recordcase(self.test_switchtab, "Notification.Priority1")
        self._launch_browser()
        self._createtab()
        for i in xrange(20):
            d(packageName="com.chaozhuo.browser", index=str(i), className="android.widget.RelativeLayout").click()
            time.sleep(2)
        u.log()

    def test_openclose(self):
        for i in xrange(self.loop):
            self._launch_browser()
            self._createtab()
            for j in xrange(5):
                d.press("back")

    def _createtab(self):
        for i in xrange(20):
            d(resourceId="com.chaozhuo.browser:id/newtab").click()
            time.sleep(2)
            d(resourceId="com.chaozhuo.browser:id/toolbar_url").set_text(self.url_list[i])
            time.sleep(2)
            d.press("enter")
            time.sleep(2)

    def _launch_browser(self):
        cmp = "com.chaozhuo.browser/org.chromium.chrome.shell.ChaoZhuoActivity"
        d.start_activity(cmp)


@unittest.skip("Skip the Priority 2 test cases")
class Priority2(unittest.TestCase):
    def setUp(self):
        self.loop = u.getloop()
        u.clog()
        u.checkScreen()
        u.setUp()

    def _launch_browser(self):
        cmp = "com.chaozhuo.browser/org.chromium.chrome.shell.ChaoZhuoActivity"
        d.start_activity(cmp)

    def test_launch(self):
        for i in xrange(self.loop):
            self._launch_browser()
            time.sleep(2)
            for i in xrange(4):
                d.press("back")
    #1305 100个标签
    def test_newtab(self):
        self._launch_browser()
        for i in xrange(50):
            d(resourceId="com.chaozhuo.browser:id/newtab").click()
            time.sleep(2)
        for i in xrange(50):
            d(resourceId="com.chaozhuo.browser:id/tabbar_item_close").click()
            time.sleep(2)
    #1307 taobao jindong
    def test_taobao(self):
        url =[]
        url.append("www.taobao.com")
        url.append("www.jd.com")
        url.append("www.sina.com.cn")
        url.append("www.qq.com")
        url.append("www.youku.com")
        self._launch_browser()
        for i in xrange(self.loop):
            for item in url:
                d(resourceId="com.chaozhuo.browser:id/newtab").click()
                time.sleep(2)
                d(resourceId="com.chaozhuo.browser:id/toolbar_url").set_text(item)
                time.sleep(2)
                d.press("enter")
                time.sleep(5)

            for item in xrange(len(url)):
                d(resourceId="com.chaozhuo.browser:id/tabbar_item_close").click()
                time.sleep(2)


    def tearDown(self):
        u.tearDown()
