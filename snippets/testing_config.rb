file "spec/support/capybara.rb", <<-CAPYBARA
require 'capybara/rails'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
  #config.include Rails.application.routes.url_helpers
end
CAPYBARA

file "spec/support/forgery.rb", <<-FORGERY
FactoryBot.define do

  sequence :email do |n|
    Forgery(:internet).email_address
  end

  sequence :name do |n|
    Forgery(:name).full_name
  end

  sequence :first_name do |n|
    Forgery(:name).first_name
  end

  sequence :last_name do |n|
    Forgery(:name).last_name
  end
end
FORGERY

file "spec/support/as_user.rb", <<-AS_USER
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
end

# Will run the given code as the user passed in
def as_user(user=nil, &block)
  current_user = user || Factory.create(:user)
  if request.present?
    sign_in(current_user)
  else
    login_as(current_user, :scope => :user)
  end
  block.call if block.present?
  return self
end


def as_visitor(user=nil, &block)
  current_user = user || Factory.stub(:user)
  if request.present?
    sign_out(current_user)
  else
    logout(:user)
  end
  block.call if block.present?
  return self
end
AS_USER

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
FACTORY_BOT