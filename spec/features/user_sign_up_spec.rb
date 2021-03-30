require 'rails_helper'

RSpec.feature 'User sign up' do 
  let(:user) { build(:user) }

  before :each do
    visit root_path
    click_link "Sign up"
    fill_in 'user_email', with: user.email 
    fill_in 'user_first_name', with: user.first_name
    fill_in 'user_last_name', with: user.last_name
    fill_in 'user_phone', with: user.phone
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
  end

  scenario "successfully" do
    expect{
      click_button 'Sign up'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
  end

  scenario "unsuccessfully because invalid email because @ is missing", js: true do
    fill_in 'user_email', with: "invalidmail"
    click_button 'Sign up'
    message = page.find('#user_email').native.attribute('validationMessage')
    expect(message).to have_content "Please include an '@'"
  end

  scenario "unsuccessfully because invalid email because following @ is missing", js: true do
    fill_in 'user_email', with: "invalidmail@"
    click_button 'Sign up'
    message = page.find('#user_email').native.attribute('validationMessage')
    expect(message).to have_content "Please enter a part following '@'"
  end

  scenario "unsuccessfully because invalid email because there are multiple @'s' ", js: true do
    fill_in 'user_email', with: "invalidmail@@@"
    click_button 'Sign up'
    message = page.find('#user_email').native.attribute('validationMessage')
    expect(message).to have_content "A part following '@' should not contain the symbol '@'."
  end

  scenario "unsuccessfully because invalid phone number length", js: true do
    fill_in 'user_phone', with: Faker::Number.number(digits: 8) 
    click_button 'Sign up'
    message = page.find('#user_phone').native.attribute('validationMessage')
    expect(message).to have_content "Please match the requested format."
  end

  scenario "unsuccessfully because invalid password", js: true do
    fill_in 'user_password', with: Faker::Internet.password(min_length: 5, max_length: 5)
    click_button 'Sign up'
    message = page.find('#user_password').native.attribute('validationMessage')
    expect(message).to have_content "Please match the requested format."
  end

  scenario "unsuccessfully because passwords does not match", js: true do
    fill_in 'user_password_confirmation', with: Faker::Internet.password(min_length: 6)
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password", wait: 5
  end

  scenario "unsuccessfully because some field is blank", js: true do
    fill_in 'user_first_name', with: ''
    click_button 'Sign up'
    message = page.find('#user_first_name').native.attribute('validationMessage')
    expect(message).to have_content "Please fill out this field."
  end

  scenario "unsuccessfully because email is already taken", js: true do
    registered_user = create(:user)
    fill_in 'user_phone', with: registered_user.phone
    fill_in 'user_email', with: registered_user.email
    click_button 'Sign up'
    expect(page).to have_content "Email has already been taken", wait: 5
  end
end
