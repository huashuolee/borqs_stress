# -*- coding: utf-8 -*-

import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time
import os


class Priority1(unittest.TestCase):
    loop = 1

    def setUp(self):
        self.loop = u.getloop()
        u.clog()
        u.checkScreen()
        d.click(1380, 800)
        u.setUp()

    def tearDown(self):
        u.tearDown()

    # 1272	对窗口持续随机操作各100次（最小化/最大化）
    def test_max_resume(self):
        u.recordcase(self.test_max_resume, "Windows.Priority1")
        self._launch_filemanager()
        for i in xrange(self.loop):
            d(resourceId="android:id/mwMaxBtn").click()
            time.sleep(2)
            d(resourceId="android:id/mwMaxBtn").click()
            time.sleep(2)
        u.log()

    def _launch_filemanager(self):
        cmp = "com.chaozhuo.filemanager/.activities.MainActivity"
        d.start_activity(component=cmp)

    # 1275	1	打开多个窗口并循环切换100次
    def test_multiWswitch(self):
        u.recordcase(self.test_multiWswitch, "Windows.Priority1")
        positon = ["216 1572", "329 1572", "464 1572", "896 1572"]
        for item in positon:
            cmd = "adb shell input tap " + item
            os.system(cmd)
        u.log()

    def _launch_apps(self):
        cmp = []
        cmp.append("com.chaozhuo.filemanager/.activities.MainActivity")
        cmp.append("com.chaozhuo.browser/org.chromium.chrome.shell.ChaoZhuoActivity")
        cmp.append("com.chaozhuo.texteditor/.activity.TextEditorMainActivity")
        cmp.append("com.chaozhuo.permission.controller/.CZPermissionControllActivity")
        cmp.append("com.android.camera2/com.android.camera.CameraLauncher")
        cmp.append("com.android.gallery3d/.app.GalleryActivity")
        cmp.append("com.android.calculator2/.Calculator")
        cmp.append("com.android.deskclock/.DeskClock")
        for item in cmp:
            d.start_activity(component=item)
            time.sleep(2)

    # 1276	打开关闭窗口循环100次
    def test_open_close(self):
        u.recordcase(self.test_open_close, "Windows.Priority1")
        for i in xrange(self.loop):
            self._launch_filemanager()
            time.sleep(2)
            d(resourceId="android:id/mwCloseBtn").click()
            time.sleep(2)

    # 1273	1	改变窗口大小各100次（拉伸/压缩）
    def test_stretch(self):
        pass


@unittest.skip("Skip the Priority 2 test cases")
class Priority2(unittest.TestCase):
    def setUp(self):
        u.clog()
        u.checkScreen()
        d.click(1380, 800)
        u.setUp()

    def tearDown(self):
        u.tearDown()
