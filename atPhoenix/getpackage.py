# coding=utf-8

import os
import sys
import time
import subprocess

def recordname():
    import os.path
    rootdir = raw_input("输入路径：") 
    for parent,dirnames,filenames in os.walk(rootdir):   
        for filename in filenames:           
            print filename
            if filename[-3:] == "apk":
                try:
                    with open("/home/huashuolee/data/packageName.txt","aw") as f:
                        item = os.path.join(parent,filename)
                        cmd = 'aapt dump badging ' + item + " |grep package"
                        p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
                        out,err = p.communicate()
                        packagename = out.split()[1].split("=")[1]
                        print packagename

                        cmd = 'aapt dump badging ' + item + " |grep -w label"
                        p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
                        out,err = p.communicate()
                        if out == "":
                            label = "没有查到中文名"
                            print "none"
                        else:
                            print out.split()[0]
                            label = out.split()[0].split(":")[1] 
                        windows = os.path.join(parent,filename).split("/")[8]
                        f.write(filename + " " + packagename + " " +  label + " " + windows + "\r\n")
                except:
                    print "error"

             
if __name__ == "__main__":
    recordname()
