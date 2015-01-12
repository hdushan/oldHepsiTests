#!/bin/bash

bundle install

echo "xxxxxxxxxx Start jmeter warmup test"
bundle exec rake warmup[$1]

