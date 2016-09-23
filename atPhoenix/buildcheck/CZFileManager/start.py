# -*- coding: utf-8 -*-
import argparse
import sys

import common.util as u
#import common.util_copy as u
import os
import unittest
from common import HTMLTestRunner


class BeginTest:
    def __init__(self):
        self.test_suite = unittest.TestSuite()
        self.result_path = u.result_path()

    def begin_test(self):
        self.get_test_suite()
        self.get_result()

    def get_test_suite(self):
        self.test_suite = unittest.defaultTestLoader.discover('script' + os.sep + 'testcases', pattern='*_test.py')

    def get_result(self):
        result = 'testresult' + os.sep + self.result_path + os.sep +'result.html'
        fb = file(result, 'wb')
        runner = HTMLTestRunner.HTMLTestRunner(stream=fb, title='Test Result', description='Test Report')
        runner.run(self.test_suite)


"""
if __name__ == "__main__":
    BeginTest().begin_test()
"""


def parseArgs(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', dest='count', help="input the test loop, e.g. python start.py -c 100")
    args = parser.parse_args()
    if args.count:
        with open("testresult" + os.sep + "loop", "w") as f:
            f.write(args.count)
    BeginTest().begin_test()


if __name__ == '__main__':
    parseArgs(sys.argv[1:])
