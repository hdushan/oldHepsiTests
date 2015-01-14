#!/bin/bash

/usr/local/bin/bundle install --verbose

sudo killall -9 xvfb-run 2>&1 >/dev/null
sudo killall -9 cucumber 2>&1 >/dev/null
sudo killall -9 firefox 2>&1 >/dev/null

echo "Running tests against http://$1" | /usr/games/cowsay

xvfb-run -a --server-args="-screen 0 1920x1080x24" /usr/local/bin/cucumber features/"$2".feature --format pretty --format html --out results.html --format junit --out results.xml host=http://"$1"

rc=$?

if [[ $rc != 0 ]] ; then
    killall -9 xvfb-run 2>&1 >/dev/null
    exit $rc
fi

killall -8 Xvfb