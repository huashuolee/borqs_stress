import matplotlib.pyplot as plt
import numpy as np
import time
from math import *

plt.ion() 
plt.figure(1)
t = [0]
t_now = 0
m = [sin(t_now)]

for i in range(2000):
    t_now = i*0.1
    t.append(t_now)
    m.append(sin(t_now))
    plt.plot(t,m,'-r')
    plt.draw()
    time.sleep(0.01)
