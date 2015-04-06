#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{docker device-mapper-event-libs}.each do |pkg|
  package pkg do
    action :install
  end
end

service "docker" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
