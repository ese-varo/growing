require 'rails_helper'

RSpec.feature 'User login' do 
  let(:user) { create(:user) }

  before :each do
    visit root_path
    click_link "Log in"
  end

  scenario "successfully" do
    fill_in 'user_email', with: user.email 
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(current_path).to eq root_path
  end

  scenario "unsuccessfully because of invalid email" do
    fill_in 'user_email', with: Faker::Internet.unique.safe_email 
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(page).to have_content "Invalid Email or password"
  end

  scenario "unsuccessfully because of invalid password" do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: Faker::Internet.password(min_length: 6) 
    click_button 'Log in'
    expect(page).to have_content "Invalid Email or assword"
  end
end
