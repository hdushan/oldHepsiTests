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