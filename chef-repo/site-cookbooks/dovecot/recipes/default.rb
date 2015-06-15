#
# Cookbook Name:: dovecot
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "dovecot" do
  action :install
end

template "/etc/dovecot/conf.d/10-mail.conf" do
  notifies :restart, 'service[dovecot]'
end

service "dovecot" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end