#! /bin/bash

set -e

# Cleanup things
rm -rf /var/www/html/sweet-www

# Build website
bundle exec \
	jekyll build -s /home/martin/workspace/sweet_website_REPOS -d /var/www/html/sweet-www $@

