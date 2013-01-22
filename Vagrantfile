require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # config.ssh.forward_agent = true
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

  # wercker-web
  config.vm.forward_port 3000, 3000
  config.vm.share_folder "v-wercker", "/var/local/sites/wercker", "~/dev/wercker/wercker"
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-wercker", "1"]

  # wercker-pool
  #config.vm.share_folder "v-wercker-pool", "/var/local/sites/wercker-pool", "~/dev/wercker/wercker-pool"
  #config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-wercker-pool", "1"]

  # wercker-sentinel
  #config.vm.share_folder "v-wercker-sentinel", "/var/local/sites/wercker-sentinel", "~/dev/wercker/wercker-sentinel"
  #config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-wercker-sentinel", "1"]


  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :apt => { :mirror => :nl }
    }

    chef.add_recipe('apt')
    chef.add_recipe('build-essential')
    chef.add_recipe('python::pip')
    chef.add_recipe('nodeenv')
    chef.add_recipe('mongodb-10gen')
    chef.add_recipe('wercker-develop::wercker-web')

  end

end