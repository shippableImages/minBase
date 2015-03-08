#!/bin/bash

sudo su shippable
. /home/shippable/.rvm/scripts/rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
rvm get stable --auto-dotfiles

# Refresh updated rubies

rvm rm 1.9.3-p550
rvm rm 2.0.0-p594
rvm rm jruby-1.7.16.1

rvm install 1.9.3
rvm install 2.0.0
rvm install jruby

sudo chown -R shippable:shippable /home/shippable/.rvm
