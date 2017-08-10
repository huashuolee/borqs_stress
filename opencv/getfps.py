import cv2
import sys
import os
import subprocess
from common.prints import print_msg as printlog

METHOD = cv2.cv.CV_TM_SQDIFF_NORMED
THRESHOLD = 0.009


class frame():
    def __init__(self, *args):
        cmd = "rm details.txt"
        os.system(cmd)
        printlog("D",args)
        self.framecount = 0;
        self.location = args[0][0]
        self.mediafile = args[0][1]
        # mkdir pic @ the root folder
        cmd = "cd " + self.location + " && " + "mkdir pic"
        os.system(cmd)
        self.getMediainfo()

    def get_frame_count(self):
        frame_count = 1

        location = self.location + "pic"
        piclist = os.listdir(location)
        piclist.sort(key=lambda x: int(x[0:-4]))
        printlog("D","Start to compare")
        for i in xrange(len(piclist) - 1):
            subImg = cv2.imread(location + os.sep + piclist[i])  # Load the sub image
            srcImg = cv2.imread(location + os.sep + piclist[i + 1])  # Load the src image
            result = cv2.matchTemplate(subImg, srcImg, METHOD)  # comparision
            minVal = cv2.minMaxLoc(result)[0]  # Get the minimum squared difference
            if minVal >= THRESHOLD:
                frame_count += 1;
            eachC = piclist[i], piclist[i + 1], minVal,frame_count
            print eachC
            with open(self.location + os.sep + 'details.txt', 'a+') as f:
                f.write(str(eachC) + " " + str(frame_count) + " " + os.linesep)
            with open('details.txt', 'a+') as f:
                f.write(str(eachC) + " " + str(frame_count) + " " + os.linesep)
        self.framecount = frame_count
        print ("frame count:", frame_count)

    def get_fps(self):
        print "fps: "
        print self.framecount / self.duration

    def convert(self):

        input = self.mediafile
        location = self.location
        cmd = "cd " + location + " && " + "ffmpeg -i " + input + " -f rawvideo output.yuv"
        printlog("D", cmd)
        os.system(cmd)

    def extractPic(self):
        cmd = "cd " + self.location + " && " + "ffmpeg -video_size 1920x1080 -i output.yuv pic/%d.png"
        printlog("D", cmd)
        os.system(cmd)

    def getMediainfo(self):
        cmd = "mediainfo " + self.location + self.mediafile + " |grep Duration"
        p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        out,err = p.communicate()
        o1 = out.split("\n")
        duration = int(o1[0].split()[-2][:-1]) + int(o1[0].split()[-1][:2])/1000.0
        self.duration = duration

        cmd = "mediainfo " + self.mediafile + " |grep Width"




if __name__ == "__main__":
    frame = frame(sys.argv[1:])
    frame.convert()
    frame.extractPic()
    frame.get_frame_count()
