gem "devise"
gem 'sassc-rails'
gem 'kaminari'
gem 'rolify'
gem 'pg'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'rb-fsevent'
  gem 'rubocop-rspec'
  gem 'climate_control'
  gem "recipient_interceptor"
end

gem_group :test do
  gem 'factory_bot_rails'
  gem 'forgery'
end