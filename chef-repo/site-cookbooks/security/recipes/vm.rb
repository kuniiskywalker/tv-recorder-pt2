#
# Cookbook Name:: security
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/home/vagrant/.ssh" do
  owner "vagrant"
  group "vagrant"
end

# VM→サーバー接続用秘密かぎ設定
cookbook_file "/home/vagrant/.ssh/id_rsa" do
  mode 0600
  owner "vagrant"
  group "vagrant"
end

cookbook_file "/home/vagrant/.ssh/config" do
  mode 0600
  owner "vagrant"
  group "vagrant"
end
