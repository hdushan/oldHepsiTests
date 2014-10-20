## Test Setup

Basic test base setup with cucumber, capybara, selenium, capybara-webkit, headless and rspec.

First thing to do is installing ruby. You can do this by:

    brew install ruby

And you can install Bundler by:

    sudo gem install bundler --verbose

And you should install phantom.js by:

   brew install phantomjs

### Ruby

After getting into the directory, all you need to do is just installing the gems:

    bundle config build.nokogiri --use-system-libraries

    bundle install --verbose

To run your test cases with tags ;

    cucumber  --tag @regression storefront

### WebKit Headless Testing

This setup uses webkit headless out of the box.