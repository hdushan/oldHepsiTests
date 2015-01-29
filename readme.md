## OS Note

This document is for Mac OS X; if you are trying to run on Windows, please see windows_setup.md instead.

## Quickstart
To run a feature file against the test environment (supports test, live):
	`cucumber features/J_browse_and_buy.feature --format pretty environment=test`
	`cucumber features/J_browse_and_buy.feature --format pretty environment=live`

To run a feature file against an environment, with firefox (uses phantomjs if no browser specified. Supports chrome too):
	`cucumber features/J_browse_and_buy.feature --format pretty environment=live browser=firefox`
	`cucumber features/J_browse_and_buy.feature --format pretty environment=live browser=chrome`

To run all features against an environment:
    `cucumber features --format pretty environment=test`

To run a specific scenario at line number 10, in a feature file:
    `cucumber features/J_browse_and_buy.feature:10 --format pretty environment=test`

## Test Setup

Test setup with cucumber, capybara, selenium-webdriver and rspec.

#### Step 1: Install Ruby
First thing to do is installing ruby (version 1.9.3). You can do this by:

    `brew install ruby`

And you can install Bundler by:

    `sudo gem install bundler --verbose`

#### Step 2: Install gems

CD into the acceptance-tests folder and run these:

    `bundle config build.nokogiri --use-system-libraries`

    `bundle install --verbose`

#### Step 3: Install browsers
* If you want to use Firefox, install Firefox (version 33)
* If you want to use phantomjs, install phantomjs, and have the phantomjs executable available in your path
* If you want to use chrome, install google-chrome and chromedriver, and have the chromedriver executable available in your path

CD into the acceptance-tests folder and run these:

    `bundle config build.nokogiri --use-system-libraries`

    `bundle install --verbose`


## Running on a different host

When you'd like to change the environment that the tests are running against

	`cucumber features environment=<your_desired_environment>` (supports test, live)

## Running specific set of tests

You can run all journey tests by running

	`cucumber --tags @journey`

If you want to run a specific test, you can specify the file and line number

	`cucumber features/<feature_name>.feature:<line_number>`

#### Go agent requirements

Go agents require the following packages to be installed

* xvfb
* firefox
* phantomjs
* freetds-dev
* ruby1.9.3
* cowsay
* bundler gem
