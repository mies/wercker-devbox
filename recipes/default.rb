#
# Cookbook Name:: wercker-develop
# Recipe:: default
#
# Copyright 2013, wercker
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

["/var/local/nodeenv", "/var/local/sites", "/home/vagrant/switchboard"].each do |dir|
  directory dir do
    user "vagrant"
    group "vagrant"

    recursive true

    action :create
  end
end

nodeenv_nodejs "/var/local/nodeenv/#{node[:wercker_devbox][:nodejs]}" do
  user "vagrant"
  group "vagrant"

  node_version node[:wercker_devbox][:nodejs]

  action :install
end

["ruby1.9.3", "git", "lixml2-dev", "lib-xslt-dev"].each do |pkg|
  package pkg do
    action :install
  end
end

if node[:wercker_devbox][:editor] == "vim"
  package "vim" do
    action :install
  end

  execute "update-alternatives --set editor /usr/bin/vim.basic" do
    user "root"
    action :run
  end
end

if node[:wercker_devbox][:editor] == "nano"
  execute "update-alternatives --set editor /bin/nano" do
    user "root"
    action :run
  end
end

["jshint", "migrate", "coffee-script", "coffeelint", "nodeunit"].each do |pkg|
  nodeenv_npm_package pkg do
    nodeenv "/var/local/nodeenv/#{node[:wercker_devbox][:nodejs]}"
    global true
  end
end

nodeenv_npm_package "coffee-script" do
  nodeenv "/var/local/nodeenv/#{node[:wercker_devbox][:nodejs]}"
  version "1.5"
  global true
end

if node[:wercker_devbox][:use_supervisor] == true
  nodeenv_npm_package "supervisor" do
    nodeenv "/var/local/nodeenv/#{node[:wercker_devbox][:nodejs]}"
    global true
  end
end

script "autoload-nodeenv" do
  user "vagrant"
  group "vagrant"
  interpreter "bash"
  code <<-EOH
  echo ". /var/local/nodeenv/#{node[:wercker_devbox][:nodejs]}/bin/activate" >> /home/vagrant/.bashrc
  touch /home/vagrant/.autoload-nodeenv
  EOH
  not_if {File.exists?("/home/vagrant/.autoload-nodeenv")}
end
