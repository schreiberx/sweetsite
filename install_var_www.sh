#! /bin/bash

set -e

rm -rf /var/www/html/sweetsite

jekyll build -s /home/martin/workspace/sweet_website_REPOS -d /var/www/html/sweetsite

