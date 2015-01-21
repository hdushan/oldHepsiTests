#!/bin/bash

/usr/local/bin/bundle install --verbose

sudo killall -9 cucumber 2>&1 >/dev/null
sudo killall -9 phantomjs 2>&1 >/dev/null

echo "Running tests for feature $2, against http://$1" | /usr/games/cowsay

/usr/local/bin/bundle exec rake feature_run["$2","$1"]