import os

import time


class Sending(object):

    def __init__(self):
        self.serial = "025693cc635207de"

    def start(self):
        for i in xrange(1000):
            print("Test Round " + str(i))
            adb = "adb -s " + self.serial
            cmd = adb + " shell input text test" + str(i)
            os.system(cmd)
            time.sleep(5)
            cmd = adb + " shell input tap 655 1063"
            os.system(cmd)
            time.sleep(900)


if __name__ == "__main__":
    Sending().start()

