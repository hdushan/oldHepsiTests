## OS Note

This document is for Mac OS X; if you are trying to run on Windows, please see windows_setup.md instead.

## Quickstart

	cucumber --tags @journey host=http://storefront.qa.hepsiburada.com

## Test Setup

Basic test base setup with cucumber, capybara, selenium-webdriver and rspec.

First thing to do is installing ruby (version 1.9.3). You can do this by:

    brew install ruby

And you can install Bundler by:

    sudo gem install bundler --verbose

### Ruby

After getting into the directory, all you need to do is just installing the gems:

    bundle config build.nokogiri --use-system-libraries

    bundle install --verbose

To run your test cases with tags ;

    cucumber features --format pretty

### Running on a different host

When you'd like to change the environment that the tests are running against

	cucumber features host=<your_desired_host>

### Running specific set of tests

You can run all journey tests by running

	cucumber --tags @journey

If you want to run a specific test, you can specify the file and line number

	cucumber features/<feature_name>.feature:<line_number>

You can run all regression tests by running

### Linux agent requirements

Linux agents require the following packages to be installed

* xvfb
* firefox
* freetds-dev
* ruby1.9.3
* cowsay

The bundler gem also needs to be installed.
