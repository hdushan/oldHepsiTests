#!/bin/bash

echo "xxxxxxxxxx Bundle Install"
/usr/local/bin/bundle install --verbose

echo "xxxxxxxxxx Start jmeter warmup test"
bundle exec rake warmup[$1]
