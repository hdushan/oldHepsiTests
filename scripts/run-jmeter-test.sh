#!/bin/bash

echo "***** Installing gems *****"
bundle install

echo "Starting jmeter test: $1, against server: $2" | /usr/games/cowsay
bundle exec rake $1[$2]

