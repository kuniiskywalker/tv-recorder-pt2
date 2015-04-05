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
%w{ld-linux.so.2}.each do |suffix|
  package suffix do
    action :install
  end
end

cookbook_file "/usr/local/src/c44e16dbb0e2.zip" do
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install arib25' do
  action :run
  cwd '/usr/local/src'
  code <<-EOH
unzip c44e16dbb0e2.zip
cd pt1-c44e16dbb0e2/arib25
make
make install
  EOH
end

# recpt1（録画ソフト）のインストール
cookbook_file "/usr/local/src/pt1-drv_20111001.tar.gz" do
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install recpt1' do
  action :run
  cwd '/usr/local/src'
  code <<-EOH
tar zvxf pt1-drv_20111001.tar.gz
cd pt1-7662d0ecd74b/recpt1
cp ../patch/bs.patch .
patch -p0 < bs.patch
./configure --enable-b25
make clean
make
make install
  EOH
end
