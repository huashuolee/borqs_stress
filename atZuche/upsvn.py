import subprocess
import os

ROOT = "D:\work\ZXC"
up = "svn up "

for folder in os.listdir(ROOT):
	for subfolder in os.listdir(ROOT+"\\"+folder):
		if subfolder[0]!=".":
		    cmd = up + ROOT + "\\" + folder + "\\" + subfolder
		    print cmd
		    subprocess.call(cmd, shell = True)
		    if subfolder == "branches":
			    for ssfolder in os.listdir(ROOT+"\\"+folder + "\\" +"branches"):
		                    cmd = up + ROOT + "\\" + folder + "\\" + subfolder + "\\" + ssfolder
				    subprocess.call(cmd, shell = True)

			        
