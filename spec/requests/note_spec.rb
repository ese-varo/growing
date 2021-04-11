require 'rails_helper'

RSpec.describe "Notes", type: :request do
  let(:user) { create(:user) }
  before(:each) { sign_in user } 
  let(:habit) { create(:habit, user: user) }
  let(:day) { create(:day, habit: habit) }

  describe 'POST /days/:id/note' do
    context 'with valid attributes'
    it 'saves a note in the database' do
      expect  do
        post day_note_index_path(day), params: { description: build(:note).description }, xhr: true
      end.to change(Note, :count).by(1)
    end

    it 'redirects to create.js' do
      post day_note_index_path(day), params: { description: build(:note).description },  xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  context 'with invalid attributes' do
    it 'does not save a note in the database' do
      expect do
        post day_note_index_path(day), params: { description: nil }
      end.not_to change(Note, :count)
    end

    it 'redirect_to the habit details template' do
      post day_note_index_path(day), params: { description: nil }
      expect(response).to redirect_to(habit_path(habit))
    end
  end

  describe 'PUT /days/:id/note/:id' do
    before(:each) do
      @note = create(:note, noteable: day)
      @attributes = attributes_for(:note)
    end
    context 'with valid attributes' do
      it 'saves a note in the database' do
        patch day_note_path(day, @note), params: { description: @attributes['description'] }, xhr: true
        expect(assigns(:note).description).to eq(@attributes['description'])
      end

      it 'redirects to update.js' do
        patch day_note_path(day, @note, format: :js), params: { description: @attributes['description'] }, xhr: true
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid attributes' do
      it 'does not save a note in the database' do
        patch day_note_path(day, @note), params: { description: nil }
        @note.reload
        expect(@note.description).not_to eq(Faker::Lorem.paragraph)
      end

      it 'redirect_to the habit details template' do
        patch day_note_path(day, @note), params: { description: @attributes['description'] }
        expect(response).to redirect_to habits_path
      end
    end
  end

  describe 'DELETE /note/:id' do
    before(:each) do
      @note = create(:note, noteable: day)
    end
    
    it 'delete the note from the database' do
      expect {
        delete note_path(@note)
      }.to change(Note, :count).by(-1)
    end

    it 'redirects to habits_path' do
      delete note_path(@note)
      expect(response).to redirect_to habit_path(@note.noteable.habit_id)
    end
  end

end
