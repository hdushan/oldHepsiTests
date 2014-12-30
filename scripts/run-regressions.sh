#!/bin/bash

/usr/local/bin/bundle install --verbose

killall -9 Xvfb

Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:1
sleep 3
xhost +

echo "Running tests against http://$1" | /usr/games/cowsay


/usr/local/bin/cucumber features --format pretty --format html --out results.html --format junit --out results.xml host=http://"$1"

rc=$?

if [[ $rc != 0 ]] ; then
    killall -9 Xvfb
    exit $rc
fi

chmod -R 777 .
killall -9 Xvfb
chown -R go:users .
