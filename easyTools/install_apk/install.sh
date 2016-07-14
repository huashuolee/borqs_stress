#!/bin/bash
for item in `ls *.apk`;do
adb install $item
done
