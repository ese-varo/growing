require 'rails_helper'

RSpec.describe 'Habits', type: :request do
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  describe 'GET /index' do
    it 'returns http success' do
      get habits_path
      expect(response).to have_http_status(:success)
    end

    context 'with a habit saved' do
      let!(:habit) { create(:habit, user: user) }

      it 'show active habit' do
        get habits_path
        expect(response.body).to include(habit.name)
      end
    end

    context 'without a habit saved' do
      it "show message You don't have any habits yet." do
        get habits_path
        expect(response.body).to include('You don&#39;t have active habits yet.')
      end
    end
  end

  describe 'POST /habits' do
    context 'with valid attributes'
    it 'saves a habit in the database' do
      expect  do
        post habits_path, params: { habit: attributes_for(:habit, user: user).merge(habit_duration: rand(21..66)) }
      end.to change(Habit, :count).by(1)
    end

    it 'redirects to habit#show' do
      post habits_path, params: { habit: attributes_for(:habit, user: user).merge(habit_duration: rand(21..66)) }
      expect(response).to redirect_to habit_path(assigns(:habit).id)
    end
  end

  context 'with invalid attributes' do
    it 'does not save the habit in the database' do
      expect do
        post habits_path, params: { habit: attributes_for(:habit, user: user, name: nil) }
      end.not_to change(Habit, :count)
    end

    it 're-renders the index template' do
      post habits_path, params: { habit: attributes_for(:habit, user: user, name: nil) }
      expect(response).to redirect_to(habits_path)
    end
  end
end
