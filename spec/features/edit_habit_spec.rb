require 'rails_helper'

RSpec.feature "Edit a habit", type: :feature do
  let!(:user) { create(:user) }
  let!(:habit) { create(:habit, user: user) }

  context "with an authenticated user" do
    before(:each) { sign_in user }

    scenario "edit a habit" do
      visit habits_path
      page.find(:xpath, "//a[@href=" + "'" + "/habits/#{habit.id}" + "'" + "]").click
      expect(page).to have_content habit[:name]
      click_button 'Edit Habit'
      fill_in 'Name', with: habit[:name]
      fill_in 'Habit duration', with: rand(22..66)
      click_button 'Update Habit'
      expect(page).to have_content 'Habit updated successfully'
    end

    scenario "see his habit data in the edit form" do
      visit habits_path
      page.find(:xpath, "//a[@href=" + "'" + "/habits/#{habit.id}" + "'" + "]").click
      expect(page).to have_content habit[:name]
      click_button 'Edit Habit'
      expect(page).to have_content habit[:name]
      expect(page).to have_content habit[:description]
      expect(page).to have_content habit[:name]
    end

    scenario "edits a habit with an invalid name", js: true do
      visit habit_path(habit)
      click_button 'Edit Habit'
      fill_in 'Name', with: ''
      fill_in 'Description', with: habit[:description]
      fill_in 'Habit duration', with: rand(21..66)
      click_button 'Update Habit'
      message = page.find("#habit_name").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end


    scenario "edits a habit with an invalid description", js: true do
      visit habit_path(habit)
      click_button 'Edit Habit'
      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: nil
      fill_in 'Habit duration', with: rand(21..66)
      click_button 'Update Habit'
      message = page.find("#habit_description").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end
    
    scenario "edits a habit with an invalid days quantity", js: true do
      visit habit_path(habit)
      click_button 'Edit Habit'
      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: habit[:description]
      fill_in 'Habit duration', with: nil
      click_button 'Update Habit'
      message = page.find("#habit_habit_duration").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end
  end

  context "with a not authenticated user" do
    scenario "cant access /habits/:id" do
      visit habit_path(habit)
      expect(page).to have_content 'Log in'
    end
  end
end
