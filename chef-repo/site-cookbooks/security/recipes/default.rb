#
# Cookbook Name:: security
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "admin" do
  password "9b721Q"
  action   [:create]
end

group "wheel" do
  action  :modify
  members ["admin", "vagrant"]
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

service "sshd" do
  action :restart
end
