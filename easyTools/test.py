import os,sys

i = 1
info = []
info.append("test")

class convert(object):
    def begin(self):
        print i
        i = i + 1
        print info

if __name__=="__main__":
    convert().begin()
