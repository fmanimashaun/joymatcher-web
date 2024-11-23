require 'rails_helper'

RSpec.describe "Settings", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/settings/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/settings/update"
      expect(response).to have_http_status(:success)
    end
  end
end