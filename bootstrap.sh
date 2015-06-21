#!/usr/bin/env bash

# Exit if already bootstrapped
test -f /etc/bootstrapped && exit

sudo /opt/chef/embedded/bin/gem i knife-solo

date > /etc/bootstrapped