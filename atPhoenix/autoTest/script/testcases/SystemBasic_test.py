# -*- coding: utf-8 -*-

import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time



class Priority1(unittest.TestCase):
    def setUp(self):
        self.loop = u.getloop()
        u.clog()
        #u.checkScreen()
        #d.click(1380, 800)
        u.setUp()

    def tearDown(self):
        u.tearDown()

    # @unittest.skip("skip this test")
    # 1266	锁屏、开屏各100次
    def test_lock_unlock(self):
        u.recordcase(self.test_lock_unlock, "SystemBasic.Priority1")
        for i in xrange(self.loop):
            u.checkScreen()
            d.click(1380, 800)
            time.sleep(2)
            d.server.jsonrpc.sleep()
            time.sleep(2)
            u.checkScreen()
        u.log()

    # 1271 持续操作文本框
    #def test_editor(self):
    #    u.recordcase(self.test_editor, "SystemBasic.Priority1")
    #    self._launch_editor()
    #    for i in xrange(self.loop):
    #        time.sleep(1)
    #        d(resourceId="com.chaozhuo.texteditor:id/text_content").set_text("test loop: " + str(i))
    #        time.sleep(1)
    #        d(resourceId="com.chaozhuo.texteditor:id/text_content").clear_text()
    #    u.log()

    def _launch_editor(self):
        cmp = "com.chaozhuo.texteditor/.activity.TextEditorMainActivity"
        d.start_activity(component=cmp)

    # 1051 持续卸载应用100个
    def uninstall_app(self):
        pass

    # 1270	用预置图库查看200张图片

    def check_pic(self):
        pass

    def test_home_switch(self):
        u.recordcase(self.test_home_switch, "SystemBasic.Priority1")
        for i in xrange(self.loop):

            u.checkScreen()


@unittest.skip("Skip the Priority 2 test cases")
class Priority2(unittest.TestCase):
    def setUp(self):
        u.clog()
        #u.checkScreen()
        #d.click(1380, 800)
        u.setUp()

    def tearDown(self):
        u.tearDown()
