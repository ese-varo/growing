require 'rails_helper'

RSpec.feature "Navbar", type: :feature do
  before(:each) { visit root_path }
  context "when user is logged in" do
    let(:user) { create(:user) }
    before(:each) do
      find("#nav-log-in").click
      fill_in 'user_email', with: user.email 
      fill_in 'user_password', with: user.password
      find(".btn").click
    end

    scenario "Logo goes to root path", js: true do
       find('#nav-logo').click
       expect(current_path).to eq root_path
    end

    scenario "Habits link goes to habits path" do
       click_link('Habits')
       expect(current_path).to eq habits_path
    end
    
    xscenario "Profile link goes to profile path" do
    end

    scenario "Sign out link logs out the user" do
      find("#nav-sign-out").click
      expect(current_path).to eq root_path
    end
  end

  context "when user is not logged in" do
    scenario "Sign up link goes to sign up path" do
      find("#nav-sign-up").click
      expect(current_path).to eq new_user_registration_path
    end

    scenario "Log in link goes to log in path" do
      find("#nav-log-in").click
      expect(current_path).to eq new_user_session_path
    end
  end
end
