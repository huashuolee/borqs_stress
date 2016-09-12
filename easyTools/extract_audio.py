import os
import subprocess


def cp_file():
    
    filelist = os.listdir('.')

    for i in filelist:
        if i[-3:] == "mp4":
            subprocess.Popen('ffmpeg.exe -i' i '-vcodec -nv -acodec copoy' i[0:-4] '.aac')

def edit():
    pass

cp_file()
