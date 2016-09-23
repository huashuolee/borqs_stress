# -*- coding: utf-8 -*-
# case 1271
import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time


class Editor100(unittest.TestCase):
    def setUp(self):
        u.clog()
        u.checkScreen()
        d.click(1380, 800)
        u.setUp()
        self._launch_editor()

    def tearDown(self):
        u.tearDown()

    # @unittest.skip("skip this test")
    def test_editor(self):
        for i in xrange(100):
            time.sleep(1)
            d(resourceId="com.chaozhuo.texteditor:id/text_content").set_text("test loop: " + str(i))
            time.sleep(1)
            d(resourceId="com.chaozhuo.texteditor:id/text_content").clear_text()

    def _launch_editor(self):
        cmp = "com.chaozhuo.texteditor/.activity.TextEditorMainActivity"
        d.start_activity(component=cmp)


