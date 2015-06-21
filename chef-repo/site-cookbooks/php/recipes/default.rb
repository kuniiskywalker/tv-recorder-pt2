#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{php php-devel php-cli php-common php-gd php-mbstring php-mysql php-pdo php-xml php-process}.each do |suffix|
    package suffix do
        action :install
    end
end

template "/etc/php.ini" do
  source "php.ini.erb"
  mode "0644"
  notifies :restart, "service[httpd]"
end

directory "/var/log/php" do
  owner "root"
  group "root"
  mode "0700"
end