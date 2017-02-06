import os


def filter():
    with open('envsetup.sh','r') as file:
        allline = file.readlines()
        for item in allline:
            if item[0:4] == "func":
                with open('funclist.txt','aw') as f1:
                    f1.write(item)
filter()
