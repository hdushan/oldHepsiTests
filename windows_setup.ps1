## Windows Setup Ruby 1.9.3

Install chocolatey:

    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

Install ruby 1.9

    choco install ruby1.9
    
Install ruby devkit
    
    choco install ruby.devkit

Install required gems 

	gem install bundler

### Ruby

After getting into the directory, all you need to do is just installing the gems:

    bundle config build.nokogiri --use-system-libraries

    bundle install --verbose

To run your test cases with tags ;

    cucumber  --tags @regression