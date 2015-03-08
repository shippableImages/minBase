#!/bin/bash -e

# Clean all traces of the old jruby
echo "==================== Uninstalling jruby 1.7.12 ==================="
rvm uninstall jruby-1.7.12
rm -rf ~/.rvm/repos/jruby/
rm -rf ~/.rvm/gems/jruby-1.7.12

# Upgrade rvm because it now defaults to jruby 1.7.13
echo "==================== Updating rvm to fix dotfile warnings ==================="
rvm get stable --auto-dotfiles

. ~/.rvm/scripts/rvm && rvm use 1.9.2

# Install 1.7.13 because it fixes issues with 18mode
#
# As of rvm 1.25.28, jruby 1.7.13 is the default so there's 
# no need to specify a version number
echo "==================== Installing jruby 1.7.13 ==================="
rvm install jruby
