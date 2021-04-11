require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:habit) { create(:habit) }
  let(:day) { create(:day, habit: habit) }
  subject { create(:note, noteable: day) }

  describe 'validations' do
    it 'is valid with a description' do
      expect(subject).to be_valid
    end

    it 'is invalid without a description' do
      note = build(:note, description: nil)
      note.valid?
      expect(note.errors[:description]).to include("can't be blank")
    end
  end
end
