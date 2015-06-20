#!/usr/bin/env bash

# Exit if already bootstrapped
test -f /etc/bootstrapped && exit

sudo /opt/chef/embedded/bin/gem i knife-solo

sudo systemctl stop firewalld
sudo systemctl disable firewalld

date > /etc/bootstrapped