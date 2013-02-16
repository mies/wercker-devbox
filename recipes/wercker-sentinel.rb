#
# Cookbook Name:: wercker-develop
# Recipe:: wercker-sentinel
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

["lxc", "expect"].each do |pkg|
  package pkg do
    action :install
  end
end

gem_package "berkshelf" do
  gem_binary '/usr/bin/gem1.9.3'
  action :install
end

directory "/home/vagrant/wercker-sentinel" do
  user "vagrant"
  group "vagrant"

  action :create
end

["start", "init", "npm-update", "coffeelint", "test"].each do |command|
  template "/home/vagrant/wercker-sentinel/#{command}" do
    owner "vagrant"
    group "vagrant"
    mode "0755"
    source "wercker-sentinel-#{command}.erb"
  end
end