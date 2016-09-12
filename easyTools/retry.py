import os
import sys
import subprocess


def retry():
    print 'test'
    n = 1
    while n < 10:
        try:
            1/0
        except Exception as e:
            print (e, 'retry')
            n += 1

if __name__ == '__main__':
    retry()
