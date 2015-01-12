#!/bin/bash

echo "***** Installing gems *****"
bundle install

echo "***** Start jmeter test: $1, against server: $2 *****"
bundle exec rake $1[$2]

