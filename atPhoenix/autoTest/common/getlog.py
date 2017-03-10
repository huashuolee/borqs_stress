import os
from threading import Thread
import time
import subprocess


def get():
    cmd = 'adb logcat -c'
    os.system(cmd)
    cmd1 = 'adb shell logcat -v time '
    filename = time.strftime("%Y%m%d%H%M", time.localtime(time.time())) + ".log"
    with open(filename, 'w') as f:
        p = subprocess.Popen(cmd1, stdout=f, stderr=subprocess.PIPE, shell=False)
    print "start ing^^^^^^^^^^^^^^^^^^^^^"


def kill_log():
    cmd = "adb shell ps |grep logcat"
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    out = p.communicate()


if __name__ == "__main__":
    """
    t = Thread(target=get)
    t.setDaemon(True)
    t.start()
    t.getName()
    time.sleep(10)

    print t.getName()
    """

    cmd = 'adb logcat -c'
    os.system(cmd)
    cmd1 = 'adb shell logcat -v time '
    filename = time.strftime("%Y%m%d%H%M", time.localtime(time.time())) + ".log"
    with open(filename, 'w') as f:
        p = subprocess.Popen(cmd1, stdout=f, stderr=subprocess.PIPE, shell=False)
    time.sleep(10)
    p.terminate()
    print "this is from main thread"
