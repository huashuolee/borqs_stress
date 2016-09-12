

import os

# python3
rootPath = input("input the path:　")
filelist = os.listdir(rootPath)
with open("filename.txt","w") as f:
    for item in filelist:
        if item[-3:] == "png":
            f.write("\n" + item[0:-3])
