#!/usr/bin/python
import sys
import re
import fileinput

class Color(object):

    def set_color(self,color,logcat):
        pass 

    # white
    def show_verbose(self,logcat):
        print(logcat)

    # blue
    def show_debug(self,logcat):
        print('\033[1;34m'+logcat+'\033[0m')

    # green
    def show_info(self,logcat):
        print('\033[1;32m'+logcat+'\033[0m')

    # yellow
    def show_warn(self,logcat):
        print('\033[1;33m'+logcat+'\033[0m')

    # red
    def show_error(self,logcat):
        print('\033[1;31m'+logcat+'\033[0m')

    # dark red
    def show_fatal(self,logcat):
        print('\033[1;35m'+logcat+'\033[0m')


def getlog():
    color = Color()
    if len(sys.argv) == 2:
        with open (sys.argv[1],'r') as f:
            logcat = f.readlines();
    else:
        logcat = fileinput.input()
    for line in logcat:
        #Color().show_verbose(line);
        line = line.strip()
        if re.search(r"V\/.+(\d+\):)", line):
            color.show_verbose(line)
        elif re.search(r"D\/.+(\d+\):)", line):
            color.show_debug(line)
        elif re.search(r"I\/.+(\d+\):)", line):
            color.show_info(line)
        elif re.search(r"W\/.+(\d+\):)", line):
            color.show_warn(line)
        elif re.search(r"E\/.+(\d+\):)", line):
            color.show_error(line)
        elif re.search(r"F\/.+(\d+\):)", line):
            color.show_fatal(line)
        elif re.search(r"or defaults", line):
            color.show_info(line)
        else:
            color.show_info(line)




if __name__ == "__main__":
    try:
        getlog()
    except KeyboardInterrupt:
        print("\nTerminated by user")
