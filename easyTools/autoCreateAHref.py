import os
import sys


def addToFile(path):
    filename = os.listdir(path)    
    with open("filelist.txt", "w+") as f:    
        for item in filename:
            if item[-3:] == "mp4" or item[-3:]=="mkv" or item[-3:] == "mvb":
                f.write("<a href=%s\\%s >%s</a> </br>\n"%(sys.argv[1],item,item))
                
if __name__ == "__main__":
    addToFile(sys.argv[1])