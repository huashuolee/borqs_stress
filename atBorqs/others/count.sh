#!/bin/bash

for i in `seq -w 10 -1 1`
  do
    echo -ne "\b\b$i";
    sleep 1;
  done

echo -e "\b\bhello world!"
