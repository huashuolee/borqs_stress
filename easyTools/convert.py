#coding=utf-8
import os
import sys
i=1
inf = []
inf.append("mp4")
inf.append("avi")
inf.append("wmv")
inf.append("MPG")
inf.append("mkv")
inf.append("MKV")
inf.append("rmvb")

class convert(object):
    def __init__(self,path):
        self.container = inf
        self.path = path 

    def begin(self):
        tmpfile = self.path + os.sep + "split.txt"
        with open(tmpfile,"w") as f:
            f.write("\r\n".join(os.listdir(self.path)))

        with open(tmpfile,"r") as f:
            filelist = f.readlines()

        for item in filelist:
            item = item.strip()
            if item[-3:] in self.container :
                item = self.path + os.sep + item
                item = "\"" + item + "\""
                cmd = "ffmpeg -i " + item  + " -vcodec libx264 -acodec aac  " + item + "_x264.mp4" 
                print cmd + "==========================================================================================================="
                os.system(cmd)

if __name__ == "__main__":
    convert(sys.argv[1]).begin()
