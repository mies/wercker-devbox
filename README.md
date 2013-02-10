# Wercker devbox

## Included in the devbox ##

- Nodeenv: 0.8.16 (`/var/local/nodeenv/0.8.16`)
  - jshint
  - supervisor
  - migrate
  - coffee-script
  - coffeelint
  - nodeunit
- Vagrant shared folder: `/var/local/sites` -> `~/dev/wercker` (See [Advanced use](#change-varlocalsites-folder) to override this mapping)
- MongoDB: latest version from the 10gen repository
- git
- Ruby: 1.9.3
  - Foundation: 3.2.3
  - Berkshelf
- lxc
- graphicsmagick

## How to run ##

1. Make sure you have run the [Getting started](#getting-started) instructions once.

2. Startup the virtual machine using vagrant (this may take a while).

        vagrant up

3. Once the virtual machine is loaded, ssh into the virtual machine.

        vagrant ssh

4. Initialize the wercker applications using the init scripts (needs to be executed at least once per vagrant machine).

        ~/wercker/init
        ~/wercker-pool/init
        ~/wercker-sentinel/init
        
5. Update styles using compass (only needed when working with wercker-web).

        ~/wercker/compass-compile

6. Start the desired wercker application using the startup scripts (every application needs a new ssh connection).

        ~/wercker/start
        ~/wercker-pool/start
        ~/wercker-sentinel/start

## Getting started ##

### Ubuntu ###

1. Install a recent Ruby version (1.9.3 recommended).

        sudo apt-get install ruby1.9.3

2. Install [vagrant](http://www.vagrantup.com/).

        sudo gem install vagrant
        
3. Install [Berkshelf](http://berkshelf.com/).

        sudo gem install berkshelf

4. Create the default directory layout.

        mkdir -p ~/dev/wercker/{wercker,wercker-pool,wercker-sentinel,keys/wercker-pool}/
        
5. git clone the wercker projects.

        git clone --recursive git@github.com:wercker/wercker.git ~/dev/wercker/wercker/
        git clone --recursive git@github.com:wercker/wercker-pool.git ~/dev/wercker/wercker-pool/
        git clone --recursive git@github.com:wercker/wercker-sentinel.git ~/dev/wercker/wercker-sentinel/

6. Copy the wercker private ssh key.

        cp location_of_private_key ~/dev/wercker/keys/wercker-pool/id_rsa

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

After this you can follow the Ubuntu instructions from step 2. That's it!

## Advanced use ##

### Change /var/local/sites folder ###

It is possible to change the mapping of the /var/local/sites/ to point to a different directory (default is `/var/local/sites` -> `~/dev/wercker`). To change this you need to set the `WERCKER_DEVBOX_SITESPATH` environment variable.

    WERCKER_DEVBOX_SITESPATH=./

### Change memory size of the devbox ###

The memory size defaults to 1024mb. This can be overwritten by setting the `WERCKER_DEVBOX_MEMORY` environment variable.

    WERCKER_DEVBOX_MEMORY=4096

### Change default editor ###

The wercker devbox defaults to the default editor of ubuntu (currently nano) This can be changed to vim or nano by setting the WERCKER_DEVBOX_EDITOR environment variable.

    WERCKER_DEVBOX_EDITOR=vim
