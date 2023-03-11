#! /bin/bash

set -e

# Cleanup things
rm -rf /var/www/html/sweetsite

# Build website
bundle exec \
	jekyll build -s /home/martin/workspace/sweet_website_REPOS -d /var/www/html/sweetsite $@

