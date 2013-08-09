source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
group :production do
	gem 'pg'
	gem 'rails_12factor'
end

group :development, :test do
	gem 'sqlite3'
  	gem "better_errors"
  	gem 'pry'
  	gem 'binding_of_caller'
end

gem 'twitter-bootstrap-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'omniauth-facebook'
gem 'paperclip', '~> 3.0'
gem 'simple_form', '3.0.0.rc'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end


