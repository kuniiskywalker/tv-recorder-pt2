#
# Cookbook Name:: security
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/root/bin" do
  owner 'root'
  group 'root'
  action :create
end

cookbook_file "/root/bin/chroot-useradd" do
  mode  "0755"
  owner "root"
  group "root"
end

service "sshd" do
  action :restart
end

# SELinuxによるアクセス制御を全て無効
cookbook_file "/etc/selinux/config" do
  source "selinux/config"
  mode 0644
  owner "root"
  group "root"
  notifies :run, 'bash[change-SELINUX-disabled]', :immediately
end

bash "change-SELINUX-disabled" do
  action :nothing
  code <<-EOH
sudo setenforce Permissive
  EOH
end