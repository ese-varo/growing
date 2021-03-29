require 'rails_helper'

RSpec.describe "Habits", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/habits/index"
      expect(response).to have_http_status(:success)
    end
  end

end
