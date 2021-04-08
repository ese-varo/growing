require 'rails_helper'

RSpec.feature "CreateNewHabits", type: :feature do
  let(:user) { create(:user) }
  let(:habit) { attributes_for(:habit, user: user) }

  context "with an authenticated user" do
    before(:each) { sign_in user }
    scenario "create a new habit" do
      visit habits_path
      click_button 'Add New Habit'
      expect(page).to have_content 'Create a new habit'

      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: habit[:description]
      fill_in 'Start date', with: habit[:start_date]
      fill_in 'Habit duration', with: rand(22..66)
      click_button 'Create habit'
      expect(page).to have_content habit[:name]
    end

    scenario "a new habit has to show you the details of the habit" do 
      visit habits_path
      click_button 'Add New Habit'
      expect(page).to have_content 'Create a new habit'

      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: habit[:description]
      fill_in 'Start date', with: habit[:start_date]
      fill_in 'Habit duration', with: rand(22..66)
      click_button 'Create habit'
      expect(page).to have_content habit[:name]
      expect(page).to have_content habit[:description]
      expect(page).to have_content habit[:start_date].to_s(:long)
    end 

    scenario "create a new habit with an invalid name", js: true do
      visit habits_path
      click_button 'Add New Habit'
      expect(page).to have_content 'Create a new habit'

      fill_in 'Name', with: ''
      fill_in 'Description', with: habit[:description]
      fill_in 'Start date', with: habit[:start_date]
      fill_in 'Habit duration', with: rand(21..66)
      click_button 'Create habit'
      message = page.find("#habit_name").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end

    scenario "create a new habit with an invalid description", js: true do
      visit habits_path
      click_button 'Add New Habit'
      expect(page).to have_content 'Create a new habit'

      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: nil
      fill_in 'Start date', with: habit[:start_date]
      fill_in 'Habit duration', with: rand(21..66)
      click_button 'Create habit'
      message = page.find("#habit_description").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end

    scenario "create a new habit with an invalid start_date", js: true do
      visit habits_path
      click_button 'Add New Habit'
      expect(page).to have_content 'Create a new habit'

      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: habit[:description]
      fill_in 'Start date', with: nil
      fill_in 'Habit duration', with: rand(21..66)
      click_button 'Create habit'
      message = page.find("#habit_start_date").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end

    scenario "create a new habit with an invalid quantity", js: true do
      visit habits_path
      click_button 'Add New Habit'
      expect(page).to have_content 'Create a new habit'

      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: habit[:description]
      fill_in 'Start date', with: habit[:start_date]
      fill_in 'Habit duration', with: nil
      click_button 'Create habit'
      message = page.find("#habit_habit_duration").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end
  end

  scenario "index can't be access by a not authenticated user" do
    visit habits_path
    expect(page).to have_content 'Log in'
  end
end
