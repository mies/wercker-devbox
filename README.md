# Wercker devbox

## Included in the devbox ##

- Nodeenv: 0.8.16 (/var/local/nodeenv/0.8.16)
- Vagrant shared folder: /var/local/sites -> ~/dev/wercker (See Advanced use to override this mapping)

## How to install ##

### Ubuntu ###

1. Install Berkshelf (http://berkshelf.com/)

        gem install berkshelf
2. Run vagrant up (http://www.vagrantup.com/)

        vagrant up


### OS X ###
Using berkshelf and vagrant on OS X is exactly the same as on Ubuntu, however, there are can be some complications:
* the machine does not have a recent version of ruby installed (>1.9.1) you will have to take some additional steps.
* vagrant is installed via the installer and might not have installed berkshelf via the bundled ruby gem installer. To avoid this last problem, we'll install vagrant via ruby gems and not use the packaged vagrant installer.

Note: The next steps assume you have homebrew installed.


1. Install ruby:

        brew install ruby


2. Make sure the ruby you've just installed is being used. Try:

        ruby -v

  This should result in something like:

        ruby 1.9.3p374 (2013-01-15 revision 38858) [x86_64-darwin12.2.1]

  If not, your paths are probably not setup correctly. Run the follow for diagnostics:

        brew doctor

3. You might want to create a symbolic link to vagrant for easier use:

        cd /usr/local/bin
        ln -s ../Cellar/ruby/1.9.3-p374/bin/vagrant

After this you can follow the Ubuntu instructions. That's it!

## TODO ##

- Make VM memory size configurable
- Install Ruby 1.9.3
- Install zurb-foundation gem

## Advanced use ##

### Change /var/local/sites folder ###

It is possible to change the mapping of the /var/local/sites/ to point to a different directory (default is /var/local/sites -> ~/dev/wercker). To change this you need to set the `WERCKER_DEVBOX_SITESPATH`.
```