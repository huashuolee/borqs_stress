import os
import sys
i=1

with open("split.txt","w") as f:
    f.write("\r\n".join(os.listdir(os.getcwd())))

with open("split.txt","r") as f:
    filelist = f.readlines()


for item in filelist:
    item = item.strip()
    if item[-3:] == sys.argv[1] :
        cmd = "ffmpeg -i " + item  + " -vcodec libx265 -acodec libmp3lame  " + item + "_h265.mp4" 
        print cmd + "==========================================================================================================="
	i = i + 1
        os.system(cmd)
