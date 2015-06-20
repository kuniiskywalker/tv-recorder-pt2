#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#package "mysql-server" do
#    action :install
#end

execute 'get mysql repository packege' do
  cwd '/tmp'
  command 'wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm'
  not_if { ::File.exists?("/tmp/mysql-community-release-el7-5.noarch.rpm") }
end

rpm_package "mysql-community-release-el7-5.noarch.rpm" do
  action :install
  source "/tmp/mysql-community-release-el7-5.noarch.rpm"
end


package "mysql-community-server" do
  action :install
  options '--enablerepo=mysql56-community'
end

template "/etc/my.cnf" do
  notifies :restart, 'service[mysqld]'
end

directory "/var/log/mysql" do
  owner  "mysql"
  group  "root"
  mode '0755'
  action :create
end

service "mysqld" do
  action [ :enable, :start]
end

# secure install

execute "secure_install" do
  command "/usr/bin/mysql -u root < /tmp/secure_install.sql"
  action :nothing
  only_if "/usr/bin/mysql -u root -e 'show databases;'"
end

template "/tmp/secure_install.sql" do
  owner "root"
  group "root"
  mode 0777
  notifies :run, "execute[secure_install]", :immediately
end

# create the databases
if node['mysql']['root']
  node['mysql']['databases'].each do |name|
    execute "create database #{name}" do
      command "mysql -u#{node['mysql']['root']['name']} -p#{node['mysql']['root']['password']} -e 'create database if not exists #{name}'"
      user "root"
    end
  end
end