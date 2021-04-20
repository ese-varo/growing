source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

gem 'dotenv-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'letter_opener'
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 4.1.0'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano3-puma', require: false
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0', require: false
  gem 'ed25519', '>= 1.2', '< 2.0'
end


group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
  gem 'faker', '~> 2.16'
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'
  gem 'rexml', '~> 3.2', '>= 3.2.4'
  gem 'simplecov', '~> 0.21.2'
  gem 'rails-controller-testing'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'devise'
gem 'react-rails'
gem 'sidekiq', '~> 6.1', '>= 6.1.3'
gem 'sidekiq-cron', '~> 1.2'
gem 'redis', '~> 4.2', '>= 4.2.5'
gem 'haml', '~> 5.2', '>= 5.2.1'
