#
# Cookbook Name:: recpt1
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#事前準備
%w{unzip bzip2 at}.each do |suffix|
  package suffix do
    action :install
  end
end

%w{gcc gcc-c++ kernel-devel make autogen automake patch perl-ExtUtils-MakeMaker}.each do |suffix|
  package suffix do
    action :install
  end
end

# カードリーダ用ソフトウェアをインストール
%w{ccid pcsc-lite pcsc-lite-devel pcsc-lite-libs}.each do |suffix|
  package suffix do
    action :install
  end
end

# カードリーダ用ソフトウェアをインストール
cookbook_file "/usr/local/src/pcsc-perl-1.4.13.tar.bz2" do
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install pcsc-perl' do
  action :run
  cwd '/usr/local/src'
  code <<-EOH
tar jxvf pcsc-perl-1.4.13.tar.bz2
cd pcsc-perl-1.4.13
perl Makefile.PL
make
make install
  EOH
end

cookbook_file "/usr/local/src/pcsc-tools-1.4.23.tar.gz" do
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install pcsc-tools' do
  action :run
  cwd '/usr/local/src'
  code <<-EOH
tar zvxf pcsc-tools-1.4.23.tar.gz
cd pcsc-tools-1.4.23
make
make install
  EOH
end

service "pcscd" do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end











# arib25（放送波のデコード）のインストール
package "ld-linux.so.2" do
  action :install
end

remote_directory "/usr/local/src/libarib25" do
  mode 0777
  owner "admin"
  group "admin"
end

bash 'make and install arib25' do
  action :run
  cwd '/usr/local/src/libarib25'
  code <<-EOH
make
sudo make install
  EOH
end

# recpt1（録画ソフト）のインストール
remote_directory "/usr/local/src/recpt1" do
  source "recpt1-stz"
  mode 0777
  owner "admin"
  group "admin"
end

bash 'make and install recpt1' do
  action :run
  cwd '/usr/local/src/recpt1/recpt1'
  code <<-EOH
chmod 777 autogen.sh
./autogen.sh
./configure --prefix=/usr --enable-b25
make
sudo make install
  EOH
end
