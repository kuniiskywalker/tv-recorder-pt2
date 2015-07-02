#
# Cookbook Name:: epgrec
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "expect" do
  action :install
end

remote_directory "/usr/local/src/epgdump" do
  source "epgdump-stz"
  mode 0777
  owner "root"
  group "root"
end

bash 'make and install epgdump' do
  action :run
  cwd '/usr/local/src/epgdump'
  code <<-EOH
sudo make
sudo make install
  EOH
end

remote_directory "/usr/local/bin/epgrec" do
  source "epgrec-stz"
  mode 0777
  owner "apache"
  group "apache"
end

template "/etc/httpd/conf.d/epgrec.conf" do
  notifies :restart, 'service[httpd]'
end


bash 'make and install epgrec' do
  action :run
  cwd '/usr/local/bin/epgrec'
  code <<-EOH
sudo usermod -s /bin/bash apache
sudo chmod 755 do-record.sh
sudo chmod 755 recorder.php
sudo chmod 755 getepg.php
sudo chmod 755 storeProgram.php
sudo chmod 755 gen-thumbnail.sh
sudo chmod 755 recommendProgram.php
ln -s /home/share/tv tv
sudo cp cron.d/getepg /etc/cron.d/
  EOH
end

bash 'replace new line' do
  action :run
  cwd '/usr/local/bin/epgrec'
  code <<-EOH
sudo sed -i 's/\r//' epgwakealarm.php
sudo sed -i 's/\r//' getepg.old.php
sudo sed -i 's/\r//' getepg.php
sudo sed -i 's/\r//' mediatomb.php
sudo sed -i 's/\r//' recomplete.php
sudo sed -i 's/\r//' recorder.php
sudo sed -i 's/\r//' storeProgram.php
sudo sed -i 's/\r//' upgrade_2012_04_22.php
sudo sed -i 's/\r//' upgrade_db.php
sudo sed -i 's/\r//' recommendProgram.php

sudo sed -i 's/\r//' do-record.sh
sudo sed -i 's/\r//' do-record.sh.friio
sudo sed -i 's/\r//' do-record.sh.fsusb2n
sudo sed -i 's/\r//' do-record.sh.pt1
sudo sed -i 's/\r//' gen-thumbnail.sh
sudo sed -i 's/\r//' cron.d/getepg
sudo sed -i 's/\r//' init.d/epgwakealarm
  EOH
end