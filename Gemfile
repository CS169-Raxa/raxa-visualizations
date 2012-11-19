source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'simplecov', :require => false
  gem 'spork-rails'
  gem 'watchr'
end
group :production do
  gem 'pg'
end

# https://devcenter.heroku.com/articles/rails3#webserver
# installed in all groups to allow for local testing before deployment
gem 'thin'
gem 'descriptive_statistics'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  # gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'haml'
gem 'haml-rails'

gem 'factory_girl_rails'

gem 'chronic'
gem 'chronic_duration'

gem 'psych'
