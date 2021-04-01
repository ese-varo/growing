require 'rails_helper'

RSpec.describe "Habits", type: :request do
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  describe "GET /index" do
    it "returns http success" do
      get "/habits"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /habits" do
    context "with valid attributes"
      it "saves a habit in the database" do
        expect{
          post habits_path, params: { habit: attributes_for(:habit, user: user).merge(habit_duration: rand(21..66)) }
        }.to change(Habit, :count).by(1)
      end

      it "redirects to habit#show" do
        post habits_path, params: { habit: attributes_for(:habit, user: user).merge(habit_duration: rand(21..66))}
        expect(response).to redirect_to habit_path(assigns(:habit).id)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the habit in the database" do
        expect{
          post habits_path, params: { habit: attributes_for(:habit, user: user, name: nil) }
        }.not_to change(Habit, :count)
      end

      it "re-renders the index template" do
        post habits_path, params: { habit: attributes_for(:habit, user: user, name: nil) }
        expect(response).to render_template :index
      end
    end
end
