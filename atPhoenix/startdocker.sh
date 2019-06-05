#!/bin/bash
sudo docker run -d --name $1 \
      -v /home/huashuolee/extra_data/Intel_edu_Haier:/opt/android_source/Intel_edu_Haier \
      -v /home/huashuolee/extra_data/PhoenixOne:/opt/android_source/PhoenixOne \
      -v /home/huashuolee/extra_data/android-x86:/opt/android_source/android-x86 \
      -v /home/huashuolee/extra_data/lineage15.1:/opt/android_source/lineage15.1 \
      -v /home/huashuolee/extra_data/cm14.1:/opt/android_source/lineage14.1 \
      -v /home/huashuolee/extra_data/android-8.1.0_r38:/opt/android_source/android-8.1.0_r38 \
      -v /home/huashuolee/extra_data/celadon:/opt/android_source/celadon \
      -v /home/huashuolee/data/myandroid/phoenixos_x86_intel_edu:/opt/android_source/Intel_edu_Teclast \
      -v /home/huashuolee/data/myandroid/phoenixos_x86_64:/opt/android_source/phoenixos_x86_64_official\
      -v /home/huashuolee/ccache:/opt/ccache \
      -v /home/huashuolee/docker/share:/opt/share \
      -p 8080:8080 -p 50000:50000 \
      $2\
      java -jar /opt/jenkins/jenkins.war
