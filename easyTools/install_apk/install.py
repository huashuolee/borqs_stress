import os
import subprocess

p = subprocess.Popen('ls', shell =True, stdout = subprocess.PIPE)
stdlist, stderr = p.communicate()
apklist = stdlist.split('\n')
for item in apklist:
    if item[-3:]=="apk":
        item = item.encode("utf-8")
        cmd = 'adb install ' + item
        os.system(cmd)



