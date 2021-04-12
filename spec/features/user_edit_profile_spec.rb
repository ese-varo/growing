require 'rails_helper'

RSpec.feature 'User' do 
  let!(:user) { create(:user) }

  scenario "can update their profile successfully" do
    sign_in user
    visit edit_user_registration_path
    previous_user_data = user
    valid_password = Faker::Internet.password(min_length: 6)

    fill_in 'user_email', with: Faker::Internet.unique.safe_email
    fill_in 'user_first_name', with: Faker::Name.first_name
    fill_in 'user_last_name', with: Faker::Name.last_name
    fill_in 'user_phone', with: Faker::PhoneNumber.cell_phone_in_e164
    fill_in 'user_password', with: valid_password
    fill_in 'user_password_confirmation', with: valid_password
    fill_in 'user_current_password', with: user.password
    click_button 'Update'
    expect(page).to have_content "Your account has been updated successfully"
    expect(current_path).to eq profile_path
  end

  context "can't update their profile" do
    before(:each) do
      sign_in user
      visit edit_user_registration_path
    end

    scenario "without first name", js: true do
      fill_in 'user_first_name', with: nil
      click_button 'Update'
      message = page.find('#user_first_name').native.attribute('validationMessage')
      expect(message).to have_content "Please fill out this field"
    end

    scenario "without last name", js: true do
      fill_in 'user_last_name', with: nil
      click_button 'Update'
      message = page.find('#user_last_name').native.attribute('validationMessage')
      expect(message).to have_content "Please fill out this field"
    end

    scenario "without email", js: true do
      fill_in 'user_email', with: nil
      click_button 'Update'
      message = page.find('#user_email').native.attribute('validationMessage')
      expect(message).to have_content "Please fill out this field"
    end

    scenario "without phone", js: true do
      fill_in 'user_phone', with: nil
      click_button 'Update'
      message = page.find('#user_phone').native.attribute('validationMessage')
      expect(message).to have_content "Please fill out this field"
    end

    scenario "with invalid phone", js: true do
      fill_in 'user_phone', with: Faker::Number.number(digits: 8) 
      click_button 'Update'
      message = page.find('#user_phone').native.attribute('validationMessage')
      expect(message).to have_content "Please match the requested format."
    end

    scenario "with invalid email because following @ is missing", js: true do
      fill_in 'user_email', with: "invalidmail@"
      click_button 'Update'
      message = page.find('#user_email').native.attribute('validationMessage')
      expect(message).to have_content "Please enter a part following '@'"
    end

    scenario "with invalid email because there are multiple @'s' ", js: true do
      fill_in 'user_email', with: "invalidmail@@@"
      click_button 'Update'
      message = page.find('#user_email').native.attribute('validationMessage')
      expect(message).to have_content "A part following '@' should not contain the symbol '@'."
    end

    scenario "with an already taken email" do
      registered_user = create(:user)
      fill_in 'user_email', with: registered_user.email
      click_button 'Update'
      expect(page).to have_content "Email has already been taken"
    end

    scenario "with invalid current password" do
      fill_in 'user_current_password', with: Faker::Internet.password(min_length: 6)
      click_button 'Update'
      expect(page).to have_content "Current password is invalid"
    end
  end

  context "can't update their password" do
    before(:each) do
      sign_in user
      visit edit_user_registration_path
    end

    scenario "with invalid password", js: true do
      fill_in 'user_password', with: Faker::Internet.password(min_length: 5, max_length: 5)
      click_button 'Update'
      message = page.find('#user_password').native.attribute('validationMessage')
      expect(message).to have_content "Please match the requested format."
    end

    scenario "with no matching passwords", js: true do
      fill_in 'user_password', with: Faker::Internet.password(min_length: 6)
      fill_in 'user_password_confirmation', with: Faker::Internet.password(min_length: 6)
      fill_in 'user_current_password', with: user.password
      click_button 'Update'
      expect(page).to have_content "Password confirmation doesn't match Password", wait: 5
    end
  end
end
