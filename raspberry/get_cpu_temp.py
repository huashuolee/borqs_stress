
with open("/sys/class/thermal/thermal_zone0/temp","r") as file:
    temp = float(file.read())/1000
print ("tempture:{} C ".format(temp))

