#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{postfix cyrus-sasl}.each do |suffix|
    package suffix do
        action :install
    end
end

template "/etc/postfix/main.cf" do
  notifies :restart, 'service[postfix]'
end

template "/etc/postfix/master.cf" do
  notifies :restart, 'service[postfix]'
end

%w{
	/etc/skel/Maildir
	/etc/skel/Maildir/new
	/etc/skel/Maildir/cur
	/etc/skel/Maildir/tmp
}.each do |directory_path|
	directory directory_path do
	    mode '0700'
	    action :create
	 end
end

file "/etc/postfix/virtusertable" do
  owner  "root"
  group  "root"
  mode   "0644"
  action :create
end

bash 'postmap_virtusertable' do
  not_if { ::File.exists?("/etc/postfix/virtusertable.db") }
  user 'root'

  code <<-EOL
    postmap /etc/postfix/virtusertable
  EOL
end

service "saslauthd" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

service "postfix" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end