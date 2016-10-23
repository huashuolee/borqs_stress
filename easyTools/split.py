import os
time = []
starttime=""
stoptime=""
i=1

with open("split.txt","r") as f:
    time = f.readlines()


for item in time:
    starttime = starttime.join(item[:2])+ ":" + starttime.join(item[2:4]) + ":" + starttime.join(item[4:6])
    stoptime = stoptime.join(item[7:9]) + ":" + stoptime.join(item[9:11]) + ":" + stoptime.join(item[11:13])
    splitfile= str(i) + ".mp4"
    cmd = "ffmpeg -i integartion.mp4 -ss " + starttime + " -to " + stoptime + " -vcodec copy -acodec copy  " + splitfile 
    i = i + 1
    print cmd + "==========================================================================================================="
    os.system(cmd)
    starttime = ""
    stoptime = ""
	

