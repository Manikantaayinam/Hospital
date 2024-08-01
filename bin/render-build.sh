#!/usr/bin/env bash
set -o errexit

bundle install
chmod +x bin/rails
rails webpacker:install
RAILS_ENV=production bin/rails assets:precompile

bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:seed
