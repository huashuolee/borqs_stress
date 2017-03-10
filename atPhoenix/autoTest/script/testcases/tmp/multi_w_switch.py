# -*- coding: utf-8 -*-
# case 1271
import os
import unittest
import common.util as u
from uiautomatorplug.android import device as d
import time

"""
issues:
1. adb always offline
2. using x, y to tap
3. low memory
"""
class Editor100(unittest.TestCase):
    def setUp(self):
        u.clog()
        u.checkScreen()
        d.click(1380, 800)
        u.setUp()
        self._launch_apps()

    def tearDown(self):
        u.tearDown()

    # @unittest.skip("skip this test")
    def test_editor(self):
        positon = ["216 1572", "329 1572","464 1572","896 1572"]
        for item in positon:
            cmd="adb shell input tap " + item
            os.system(cmd)
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
