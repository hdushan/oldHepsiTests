#!/bin/bash

/usr/local/bin/bundle install

echo "xxxxxxxxxx Start jmeter warmup test"
bundle exec rake warmup[$1]

