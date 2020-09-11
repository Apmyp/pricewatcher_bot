# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

gem 'counter_culture', '~> 2.0'
gem 'daemons'
gem 'dry-struct', '>= 1.0.0'
gem 'nanoid', '>= 2.0.0'
gem 'nokogiri', '>= 1.10.9'
gem 'redis-rails', '>= 5.0.2'
gem 'sentry-raven'
gem 'sidekiq', '>= 6.0.6'
gem 'skylight'
gem 'telegram-bot', '>= 0.14.3'
gem 'whenever', '>= 1.0.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '>= 5.1.1'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '>= 4.0.0'
  gem 'webmock', '>= 3.8.3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'brakeman', '>= 4.8.0'
  gem 'bullet'
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano3-puma'
  gem 'capistrano-bundler', '~> 1.6'
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-sentry', require: false
  gem 'capistrano-sidekiq'
  gem 'rubocop-rails', '>= 2.5.1', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
