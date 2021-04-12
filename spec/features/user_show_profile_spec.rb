require 'rails_helper'

RSpec.feature 'User' do 
  let(:user) { create(:user) }

  context "when logged in" do
    before(:each) { sign_in user }

    scenario "can see their profile page" do
      visit profile_path
      expect(page).to have_content "My Profile"
    end
  end

  scenario "can't access profile page if they're not logged in" do
    visit profile_path
    expect(page).to have_content "You must be logged in"
  end
end
