#!/bin/bash

/usr/local/bin/bundle install --verbose

killall -9 Xvfb

Xvfb :1 -screen 0 1024x768x24 2>&1 >/dev/null &
export DISPLAY=:1
sleep 3
xhost +

echo "xxxxxxxxxx Start jmeter warmup test" | /usr/games/cowsay
bundle exec rake warmup

rc=$?

if [[ $rc != 0 ]] ; then
    killall -9 Xvfb
    exit $rc
fi

chmod -R 777 .
killall -9 Xvfb
chown -R go:users .
