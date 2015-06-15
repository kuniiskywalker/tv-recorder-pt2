#
# Cookbook Name:: security
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/home/vagrant/.ssh/id_rsa" do
  mode 0600
  owner "vagrant"
  group "vagrant"
end

template "/home/vagrant/.ssh/config" do
  mode 0600
  owner "vagrant"
  group "vagrant"
end
