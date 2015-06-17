#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{httpd mod_ssl}.each do |suffix|
  package suffix do
    action :install
  end
end

node['httpd']['http']['hosts'].each do |data|
  directory data.htdocs do
      owner  "admin"
      group  "admin"
      mode '0777'
      action :create
   end
end

template "/usr/sbin/pp_filter" do
  source "pp_filter.erb"
  owner  "root"
  group  "root"
  mode '0777'
end

template "/etc/httpd/conf.d/vhost.conf" do
end

template "/etc/httpd/conf.d/ssl.conf" do
end

%w{/etc/httpd/conf.d/ssl.key /etc/httpd/conf.d/ssl.crt /etc/httpd/conf.d/ssl.cabundle}.each do |folder|
  directory folder do
    owner  "root"
    group  "root"
    mode '0755'
    action :create
  end
end

template "/etc/httpd/conf/httpd.conf" do
  notifies :restart, 'service[httpd]'
end

node['httpd']['https']['hosts'].each do |data|
  cookbook_file "/etc/httpd/conf.d/ssl.key/" + data[:key] do
    owner "root"
    group "root"
    mode "0755"
  end
  cookbook_file "/etc/httpd/conf.d/ssl.crt/" + data[:crt] do
    owner "root"
    group "root"
    mode "0755"
  end
  cookbook_file "/etc/httpd/conf.d/ssl.cabundle/" + data[:cabundle] do
    owner "root"
    group "root"
    mode "0755"
  end
end

service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

