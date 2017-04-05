from uiautomator import device as d
import unittest
import time
import HTMLTestRunner

print d.info


class FullTest(unittest.TestCase):
    def setUp(self):
        pass

    def test_carinfo(self):
        for loop in range(1):
            self.assertFalse(d(className="android.widget.RadioButton", resourceId="com.ucs:id/desk_tab_carinfo").click())
            self.assertFalse(d(className="android.widget.RadioButton", resourceId="com.ucs:id/desk_tab_utils").click())
            self.assertTrue(d(className="android.widget.RadioButton", resourceId="com.ucs:id/desk_tab_desk").click())
    
    def test_switch(self):
        self.assertTrue(d(className="android.widget.RadioButton", resourceId="com.ucs:id/desk_tab_desk").click())
        
    def test_a(self):
        try:
            raise Exception
        except:
            assert False

if __name__ == "__main__":
    testsuite = unittest.TestLoader().loadTestsFromTestCase(FullTest)
    ISOTIMEFORMAT = '%Y-%m-%d-%H-%M-%S'
    result = 'D:\\work\\code\\selenium\\testresult\\' + time.strftime(ISOTIMEFORMAT, time.gmtime(time.time())) + '_result.html'
    fb = file(result, 'wb')
    runner = HTMLTestRunner.HTMLTestRunner(stream=fb,title='Test Result', description='Test Report')
    runner.run(testsuite)
