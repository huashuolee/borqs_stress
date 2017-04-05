# -*- coding: utf-8 -*-
from uiautomatorplug.android import device as d
import unittest
import time


class Rotation(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_rotation(self):
        for i in xrange(10):
            d.orientation = "l"
            time.sleep(2)
            d.orientation = "n"
            time.sleep(2)
            d.orientation = "r"
            time.sleep(2)
            d.orientation = "n"
            d.orientation = "l"
            time.sleep(2)
            d.orientation = "r"
