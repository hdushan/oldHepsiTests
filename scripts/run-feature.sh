#!/bin/bash

/usr/local/bin/bundle install --verbose

sudo killall -9 xvfb-run 2>&1 >/dev/null
sudo killall -9 cucumber 2>&1 >/dev/null
sudo killall -9 firefox 2>&1 >/dev/null

echo "Running tests for feature $2, against http://$1" | /usr/games/cowsay

xvfb-run -a --server-args="-screen 0 1920x1080x24" host=http://"$1" /usr/local/bin/bundle exec rake feature["$2"]

rc=$?

if [[ $rc != 0 ]] ; then
    killall -9 xvfb-run 2>&1 >/dev/null
    exit $rc
fi

killall -8 Xvfb