#
# Cookbook Name:: twonkymedia
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# townkymedia6.0はlibgcc32bitに依存しているので一旦64bit版を削除
# 依存性を無視しないと関連パッケージもアンインストールされてしまうので、--nodepsオプション追加
rpm_package "libgcc-4.8.2-16.2.el7_0.x86_64" do
  options "--nodeps"
  action :remove
end

# 32bit互換のi686をインストール
cookbook_file "/usr/local/src/libgcc-4.8.2-16.2.el7_0.i686.rpm" do
  mode 0777
  owner "root"
  group "root"
end
package "libgcc-4.8.2-16.2.el7_0.i686" do
  action   :install
  source   "/usr/local/src/libgcc-4.8.2-16.2.el7_0.i686.rpm"
  provider Chef::Provider::Package::Rpm
end

# twonkymedia依存ライブラリ
%w{ld-linux.so.2 libstdc++.so.5}.each do |suffix|
  package suffix do
    action :install
  end
end

## twonkymediaのインストール
cookbook_file "/usr/local/src/twonkymedia-i386-glibc-2.2.5-6.0.zip" do
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install twonkymedia' do
  action :run
  cwd '/usr/local'
  code <<-EOH
unzip -d /usr/local/twonky /usr/local/src/twonkymedia-i386-glibc-2.2.5-6.0.zip
cp twonky/twonkymedia.sh /etc/init.d/twonkymedia
chmod 755 /etc/init.d/twonkymedia
systemctl load /etc/init.d/twonkymedia
  EOH
  not_if { File.exists?("/usr/local/twonky") }
end

service "twonkymedia" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end