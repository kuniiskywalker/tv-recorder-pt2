#
# Cookbook Name:: pt2
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# デフォルトのものを無効化（rootで実行しないとこける）
script "disable default pt driver" do
  interpreter "bash"
  user        "root"
  code <<-EOL
    echo "blacklist earth-pt1" >> /etc/modprobe.d/blacklist.conf
  EOL
end

#事前準備
%w{git unzip bzip2 at gcc gcc-c++ kernel-devel make autogen automake patch perl-ExtUtils-MakeMaker}.each do |suffix|
  package suffix do
    action :install
  end
end

## PT2ドライバのインストール
cookbook_file "/usr/local/src/tip.tar.bz2" do
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install pt2driver' do
  action :run
  cwd '/usr/local/src'
  code <<-EOH
tar -xvlf tip.tar.bz2
cd pt1-c8688d7d6382/driver
make
sudo make install
sudo modprobe pt1_drv
echo "/usr/local/lib" >> /etc/ld.so.conf
  EOH
end
