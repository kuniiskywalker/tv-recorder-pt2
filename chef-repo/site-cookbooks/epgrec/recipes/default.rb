#
# Cookbook Name:: epgrec
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "expect" do
  action :install
end

remote_directory "/usr/local/src/epgdump" do
  source "epgdump-stz"
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install epgdump' do
  action :run
  cwd '/usr/local/src/epgdump'
  code <<-EOH
sudo make
sudo make install
  EOH
end

remote_directory "/usr/local/bin/epgrec" do
  source "epgrec-stz"
  mode 0777
  owner "apache"
  group "apache"
end

template "/etc/httpd/conf.d/epgrec.conf" do
  notifies :restart, 'service[httpd]'
end