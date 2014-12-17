#!/bin/bash

killall -9 Xvfb

Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:1
sleep 3
xhost +

/usr/local/bin/cucumber features --format pretty --format html --out results.html --format junit --out results.xml --tags @journey
rc=$?

if [[ $rc != 0 ]] ; then
    killall -9 Xvfb
    exit $rc
fi

killall -9 Xvfb
