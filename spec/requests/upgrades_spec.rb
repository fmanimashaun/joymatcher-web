require 'rails_helper'

RSpec.describe "Upgrades", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/upgrades/index"
      expect(response).to have_http_status(:success)
    end
  end

end
