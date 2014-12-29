#!/bin/bash

/usr/local/bin/bundle install --verbose

sudo killall -9 Xvfb

sudo Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:1
sleep 3
sudo xhost +

echo "Running tests against http://$1" | /usr/games/cowsay


/usr/local/bin/cucumber features"$2" --format pretty --format html --out results.html --format junit --out results.xml --tags @journey host=http://"$1"

rc=$?

if [[ $rc != 0 ]] ; then
    sudo killall -9 Xvfb
    exit $rc
fi

sudo chmod -R 777 .
sudo killall -9 Xvfb