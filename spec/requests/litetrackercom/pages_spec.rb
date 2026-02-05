require 'rails_helper'

RSpec.describe "Litetrackercom::Pages", type: :request do
  before do
    host! "litetracker.com"
  end

  describe "GET /pivotal-tracker-alternative" do
    it "returns http success" do
      get "/pivotal-tracker-alternative"

      expect(response).to have_http_status(:success)
    end

    it "renders the pivotal tracker alternative page" do
      get "/pivotal-tracker-alternative"

      expect(response.body).to include("Pivotal Tracker Alternative")
      expect(response.body).to include("LiteTracker")
    end

    it "contains migration-focused FAQ section" do
      get "/pivotal-tracker-alternative"

      expect(response.body).to include("Migration FAQ")
      expect(response.body).to include("How do I migrate from Pivotal Tracker?")
    end
  end
end
