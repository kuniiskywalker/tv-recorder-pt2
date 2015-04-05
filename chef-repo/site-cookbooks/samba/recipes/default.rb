#
# Cookbook Name:: samba
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{samba samba-client samba-common}.each do |suffix|
  package suffix do
    action :install
  end
end

directory "/home/share" do
  owner 'nobody'
  group 'nobody'
  mode '0777'
  action :create
end

template "/etc/samba/smb.conf" do
  notifies :restart, 'service[smb]', :immediately
  notifies :restart, 'service[nmb]', :immediately
end

service "smb" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

service "nmb" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end