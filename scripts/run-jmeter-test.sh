#!/bin/bash

echo "***** Installing gems *****"
bundle install

echo "Starting jmeter test: $1, against server: $2, load: $3, rampup: $4, duration: $5. Expected pass rate: $6." | /usr/games/cowsay
bundle exec rake $1[$2,$3,$4,$5,$6]

