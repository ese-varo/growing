require 'rails_helper'

RSpec.feature "CreateNewHabits", type: :feature do
  let(:habit) { attributes_for(:habit) }

  scenario "create a new habit" do
    visit habits_path
    click_button 'Add New Habit'
    expect(page).to have_content 'Create a new habit'

    fill_in 'Name', with: habit[:name]
    fill_in 'Description', with: habit[:description]
    fill_in 'Start date', with: habit[:start_date]
    fill_in 'Quantity', with: rand(21..66)
    click_button 'Create habit'
    expect(page).to have_content habit[:name]
  end

  scenario "create a new habit with an invalid name", js: true do
    visit habits_path
    click_button 'Add New Habit'
    expect(page).to have_content 'Create a new habit'

    fill_in 'Name', with: ''
    fill_in 'Description', with: habit[:description]
    fill_in 'Start date', with: habit[:start_date]
    fill_in 'Quantity', with: rand(21..66)
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
    fill_in 'Quantity', with: rand(21..66)
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
    fill_in 'Quantity', with: rand(21..66)
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
    fill_in 'Quantity', with: nil
    click_button 'Create habit'
    message = page.find("#habit_quantity").native.attribute("validationMessage")
    expect(message).to eq "Please fill out this field."
  end



end
