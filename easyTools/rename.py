import os
import shutil
#import argv
"""
I = os.listdir('.')
for i in I:
    if i[-1] == "~":
        continue
    elif i[0:8] == "RAMOSI9S":
       name1 = i[8:]
       name2 = 'RAMOSI9PH'
       name =name2+name1
       print name
       shutil.copyfile(i, name)  
"""
# cp xxx.xml files from RAMOSI9S*, ignore *~ files

def cp_file():
    input_name = raw_input('Target production(e.g.RAMOSI9S)\n> ')
    I = os.listdir('.')
    for i in I:
        if i[0:8] == "RAMOSI9S" and i[-1] != "~":
            name1 = i[8:]
            name2 = input_name
            name =name2+name1
            print name
            shutil.copyfile(i, name)


def edit():
    pass



cp_file()
