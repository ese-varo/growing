require 'rails_helper'

RSpec.describe Day, type: :model do
  subject { create(:day) }

  describe 'associations' do
    it { should belong_to(:habit) }
  end

  describe 'validations' do
    it 'is valid with a status and a date' do
      expect(subject).to be_valid
    end

    it 'is invalid without a date' do
      day_habit = build(:day, date: nil)
      day_habit.valid?
      expect(day_habit.errors[:date]).to include("can't be blank")
    end
  end
end
