require 'rails_helper'

RSpec.describe 'Days', type: :request do
  let(:user) { create(:user) }
  before(:each) { sign_in user }
  let(:habit) { create(:habit, user: user) }
  let(:day) { create(:day, habit: habit) }
  let(:note) { create(:note, noteable: day) }

  describe 'SHOW /days/id' do
    it 'it gets the note attach' do
      get "/days/#{day.id}.js", xhr: true
      expect(response).to have_http_status(200)
    end
  end
end
