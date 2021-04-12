require 'rails_helper'

RSpec.describe Habit, type: :model do
  subject { create(:habit) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:days)}
  end

  describe 'validations' do
    it 'is valid with a name, description, start_date and end_date' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      habit = build(:habit, name: nil)
      habit.valid?
      expect(habit.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a description' do
      habit = build(:habit, description: nil)
      habit.valid?
      expect(habit.errors[:description]).to include("can't be blank")
    end

    it 'is invalid without a start_date' do
      habit = build(:habit, start_date: nil)
      habit.valid?
      expect(habit.errors[:start_date]).to include("can't be blank")
    end
    
    it 'is invalid without a end_date' do
      habit = build(:habit, end_date: nil)
      habit.valid?
      expect(habit.errors[:end_date]).to include("can't be blank")
    end
  end
end
