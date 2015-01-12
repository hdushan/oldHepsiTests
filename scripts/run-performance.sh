#!/bin/bash

bundle install

echo "xxxxxxxxxx Start jmeter performance test" | /usr/games/cowsay
bundle exec rake performance[$1]
