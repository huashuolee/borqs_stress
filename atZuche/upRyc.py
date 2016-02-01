import subprocess


cmd = "git pull "
URL = "D:\work\code\RYC_ANDROID"

def getcode():
    subprocess.call(cmd+URL, shell = True)

if __name__ == '__main__':
	getcode()
