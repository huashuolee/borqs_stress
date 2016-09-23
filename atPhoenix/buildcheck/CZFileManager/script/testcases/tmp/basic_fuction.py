# -*- coding: utf-8 -*-

from uiautomatorplug.android import device as d
import unittest
import time
from common import util as u


class Brower(unittest.TestCase):
    def setUp(self):
        u.clog()

    def test_clear_data(self):
        u.recordcase(self.test_clear_data, "Browser")
        time.sleep(10)
        assert True
        u.log()


@unittest.skip
class BasicFunction(unittest.TestCase):
    def setUp(self):
        d.start_activity(component='com.ucs/com.app.activity.index.ActivitySplash')
        time.sleep(5)

    """
    def test_start(self):
        assert d(resourceId='com.ucs:id/iv_account_icon').exists

    def test_login(self):
        if d(text=u"登陆").exists:
            assert (d(resourceId="com.ucs:id/login_butt").click())
        else:
            assert False
    """

    def test_desktop(self):
        assert (d(resourceId="com.ucs:id/btn_account_setting").click())
        time.sleep(5)
        d.click(707, 1000)

    def test_today_task(self):
        assert (d(resourceId="com.ucs:id/tv_myself_mission").click())
        time.sleep(5)
        d.press.back()

    def test_all_customers(self):
        assert (d(resourceId="com.ucs:id/my_customer").click())
        time.sleep(5)
        d.press.back()

    def test_all_orders(self):
        assert (d(resourceId="com.ucs:id/my_slip").click())
        time.sleep(5)
        d.press.back()

    def test_tab_carinfo(self):
        d(resourceId="com.ucs:id/desk_tab_carinfo").click()
        time.sleep(5)
        assert (d(resourceId="com.ucs:id/already_sailing").exists)

    def test_tab_workspace(self):
        d(resourceId="com.ucs:id/desk_tab_desk").click()
        time.sleep(5)
        assert (d(resourceId="com.ucs:id/my_customer").exists)

    def test_tab_util(self):
        assert False

    def test_car_info_als(self):
        try:
            d(resourceId="com.ucs:id/desk_tab_carinfo").click()
        except:
            raise Exception

        d(resourceId="com.ucs:id/already_sailing").click()
        time.sleep(5)
        if d(resourceId="com.ucs:id/search_result").exists:
            assert True
            d.press.back()

    def test_car_info_ns(self):
        try:
            d(resourceId="com.ucs:id/desk_tab_carinfo").click()
        except:
            raise Exception

        d(resourceId="com.ucs:id/notSailing").click()
        time.sleep(5)
        if d(resourceId="com.ucs:id/search_result").exists:
            assert True
            d.press.back

    def test_car_info_ir(self):
        try:
            d(resourceId="com.ucs:id/desk_tab_carinfo").click()
            time.sleep(2)
        except:
            raise Exception

        d(resourceId="com.ucs:id/isReady").click()
        time.sleep(5)
        if d(resourceId="com.ucs:id/search_result").exists:
            assert True
            d.press.back
