#! /bin/bash

set -e

# Cleanup vendor
rm -rf vendor

# Setup bundle location
bundle config set --local path 'vendor/bundle'

# Istall bundle (Gemfile)
bundle install

