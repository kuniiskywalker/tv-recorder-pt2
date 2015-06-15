#
# Cookbook Name:: security
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "admin" do
  password "$1$nO/7dfil$GFTXijrZzs9hMHaheC0Os/"
  action   [:create]
end

group "wheel" do
  action  :modify
  members ["admin"]
  append  true
end

# su コマンドで、wheel グループのみ root になれるように設定
template "login.defs" do
  owner  "root"
  group  "root"
  path   "/etc/login.defs"
  mode   "0440"
end

# wheel グループのユーザーのみ sudo コマンドを実行できるように設定
template "sudoers" do
  owner  "root"
  group  "root"
  path   "/etc/sudoers"
  mode   "0440"
end

# wheel グループのメンバーのみ root になれるように設定
template "su" do
  owner  "root"
  group  "root"
  path   "/etc/pam.d/su"
  mode   "0440"
end

# root での ssh ログインを禁止するように設定
# 空パスワード禁止
template "sshd_config" do
  owner  "root"
  group  "root"
  path   "/etc/ssh/sshd_config"
  mode   "0644"
end

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

cookbook_file "/home/admin/.ssh/id_rsa.pub" do
  mode 0777
  owner "admin"
  group "admin"
  notifies :run, 'bash[add-in-authorized_keys]', :immediately
end

bash "add-in-authorized_keys" do
  action :nothing
  cwd '/home/admin/.ssh/'
  code <<-EOH
cat id_rsa.pub >> authorized_keys
chmod 600 authorized_keys
chown admin.admin authorized_keys
  EOH
end