require 'rails_helper'

RSpec.feature "CRUD Notes", type: :feature, js: true do
  let(:user) { create(:user) }
  let(:habit) { create(:habit) }
  let(:note) { attributes_for(:note) }

  context "with an authenticated user" do
    before(:each) { sign_in user }

    scenario "create a new note" do
      visit habits_path
      click_button 'Add New Habit'

      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: habit[:description]
      fill_in 'Start date', with: habit[:start_date]
      fill_in 'Habit duration', with: rand(22..66)
      click_button 'Create Habit'
      find("##{Date.today.strftime('%B')}-#{Date.today.day + 1}").click
      expect(page).to have_content "You don't have a note yet"

      click_button "Create a note for today"
      fill_in 'Description', with: note[:description]
      click_button "Create note"

      expect(page).to have_content note[:description]
    end

    scenario "a new note can not be saved with an invalid description" do
      visit habits_path
      click_button 'Add New Habit'

      fill_in 'Name', with: habit[:name]
      fill_in 'Description', with: habit[:description]
      fill_in 'Start date', with: habit[:start_date]
      fill_in 'Habit duration', with: rand(22..66)
      click_button 'Create Habit'
      find("##{Date.today.strftime('%B')}-#{Date.today.day + 2}").click
      expect(page).to have_content "You don't have a note yet"

      click_button "Create a note for today", wait: 3
      click_button "Create note", wait: 3
      message = page.find("#note_description").native.attribute("validationMessage")
      expect(message).to eq "Please fill out this field."
    end

    scenario "edit a note recently saved" do
      visit habit_path(habit.id)
      day = habit.days.first
      note = create(:note, noteable: day)

      find("##{day.date.strftime('%B')}-#{day.date.day}").click

      click_button "Edit note"
      fill_in "Description", with: "New note"  
      click_button "Update", wait: 5

      expect(page).to have_content("New note")
    end

    scenario "delete a note" do
      habit = create(:habit, user: user)
      day = habit.days.first
      note = create(:note, noteable: day)
      visit habit_path(habit.id)
      find("##{day.date.strftime('%B')}-#{day.date.day}").click
 
      click_link "Delete note"
      expect(page).to have_content("Note deleted")
    end

    scenario "add a note after delete the note" do
      habit = create(:habit, user: user)
      day = habit.days.first
      note = create(:note, noteable: day)
      visit habit_path(habit.id)
      find("##{day.date.strftime('%B')}-#{day.date.day}").click
 
      click_link "Delete note"
      expect(page).to have_content("Note deleted")

      find("##{day.date.strftime('%B')}-#{day.date.day}").click
      click_button "Create a note for today"
      fill_in 'Description', with: note[:description]
      click_button "Create note"

      expect(page).to have_content note[:description]
    end
  end
end
