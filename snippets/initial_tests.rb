file "spec/features/login_spec.rb", <<-LOGIN_SPEC
require 'rails_helper'

describe "Logging in", :type => :feature do
  
  let(:user){ create(:user) }

  it "signs me in" do
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => '12345678'
      click_button 'Log in'
    end
    #save_and_open_page

    expect(page).to have_content 'Signed in successfully.'
  end
end
LOGIN_SPEC

run "rm spec/models/user_spec.rb"
file "spec/models/user_spec.rb", <<-USER_SPEC
require 'rails_helper'

RSpec.describe User, :type => :model do
  context "validation" do
    subject{ build(:user) }
    it{ should be_valid }
  end
end
USER_SPEC

run 'rm spec/factories/users.rb'
file "spec/factories/users.rb", <<-USERS
# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :user do
    email
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end
USERS