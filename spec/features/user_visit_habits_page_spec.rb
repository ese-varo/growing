require 'rails_helper'

RSpec.feature 'User visit habits page', type: :feature do
  let!(:user) { create(:user) }

  background do
    sign_in user
  end

  describe 'with a habit saved' do
    let!(:habit) { create(:habit, user: user) }

    scenario 'can see the active habit' do
      visit habits_path
      expect(page.status_code).to eq(200)
      expect(page).to have_content habit.name
    end

    scenario 'can see a message that has no archived habits' do
      visit habits_path
      expect(page.status_code).to eq(200)
      expect(page).to have_content "You don't have completed habits yet."
    end
  end

  describe 'user without a habit saved' do
    scenario 'can see a message that has no saved habits' do
      visit habits_path
      expect(page.status_code).to eq(200)
      expect(page).to have_content "You don't have active habits yet."
    end
  end
end
