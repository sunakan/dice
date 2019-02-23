# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.2"
# Use Puma as the app server
gem "puma", "~> 3.11"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# For code review
group :development do
  # rubocop
  gem "onkcop", require: false
  gem "rubocop", require: false
  # haml
  gem "haml_lint", require: false
end

group :development, :test do
  gem "rspec-rails"
  gem "simplecov"
  gem "factory_bot_rails"
  gem "faker"
  gem "gimei"
  gem "database_cleaner"
end

# (HTML)テンプレートエンジン
gem "haml-rails"

# MongoDBのORM(Object-relational mapping)
gem "mongoid"

# RDBのスキーマ管理をマイグレーション(デフォルト)=>RidgePole
gem "ridgepole"
# MySQL/MariaDBクライアント
gem "mysql2"
