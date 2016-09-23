import subprocess


class ADB(object):
    def __init__(self, serial):
        self.serial = serial
        self.adbd = 'adb -s '

    def shell(self):
        subprocess.Popen(self.adbd + self.serial + " shell")

    def logcat(self):
        subprocess.Popen(self.adbd + self.serial + " shell logcat ")

