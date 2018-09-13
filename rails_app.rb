port = ENV["PORT"] || "5000"
app_name = ARGV[1]

require 'rbconfig'
is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

# Standardize on postgres
#   Check/assume logged-in user can create databases
#   Use min_warnings
#   config/database.yml.example and perform overwrite
#   Write to readme
#
gem "pg"
if is_windows
  gem "thin"
  # https://github.com/ddollar/foreman/issues/348
  gem "foreman", "0.61.0"
 else
  gem "unicorn"
  gem "foreman"
end


gem_group :development, :test do
  gem 'rspec-rails', '~> 3.8'
  gem 'rspec-autotest'
  gem 'rb-fsevent'
end

gem_group :test do
  gem 'capybara'
  gem 'factory_bot_rails', '~> 4.11'
  gem 'forgery'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'ZenTest', '~> 4.11'
end

append_file '.gitignore', <<-GITIGNORE
config/database.yml
vendor/bundle
GITIGNORE


environment <<-APP_GENERATORS
  config.generators do |g|
    g.orm :active_record
    g.test_framework :rspec, 
      :fixtures => true, 
      :view_specs => false, 
      :helper_specs => false, 
      :routing_specs => false, 
      :controller_specs => false, 
      :request_specs => true
    g.fixture_replacement :factory_bot, :dir => "spec/factories"
  end
  config.time_zone = 'Eastern Time (US & Canada)'
APP_GENERATORS

file "spec/support/capybara.rb", <<-CAPYBARA
require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
  #config.include Rails.application.routes.url_helpers
end
CAPYBARA

file "spec/support/focus.rb", <<-FOCUS
RSpec.configure do |config|
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true
end
FOCUS

file "spec/support/factory_bot.rb", <<-FACTORY_BOT
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
FACTORY_GIRL

file "spec/support/db_cleaner.rb", <<-DB_CLEANER
require 'database_cleaner'
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
DB_CLEANER

file ".env", <<-DOTENV
PORT=#{port}
RACK_ENV=development
DOTENV

if is_windows
  file "Procfile", <<-PROCFILE
web: bundle exec thin start -p $PORT
PROCFILE

else
  file "config/unicorn.rb", <<-UNICORN
worker_processes 3
timeout 30
UNICORN

  file "Procfile", <<-PROCFILE
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
PROCFILE
end



file "config/database.yml.example", <<-DATABASE
development:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_development
  pool: 5

  # Connect on a TCP socket. Omitted by default since the client uses a
  # domain socket that doesn't need configuration. Windows does not have
  # domain sockets, so uncomment these lines.
  #host: localhost
  #port: 5432

  # Schema search path. The server defaults to $user,public
  #schema_search_path: myapp,sharedapp,public

  # Minimum log levels, in increasing order:
  #   debug5, debug4, debug3, debug2, debug1,
  #   log, notice, warning, error, fatal, and panic
  # The server defaults to notice.

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test: &test
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_test
  pool: 5
  min_messages: warning

production:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_production
  pool: 5
  min_messages: warning
DATABASE

run "bundle install"

generate "rspec:install"
if is_windows
else
  run "rm config/database.yml; cp config/database.yml.example config/database.yml"
end
rake "db:create:all"

git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
