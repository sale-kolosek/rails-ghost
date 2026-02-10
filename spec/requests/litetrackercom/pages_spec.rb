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

    it "uses pivotal-tracker-logo image_tag for the Pivotal Tracker icon" do
      get "/pivotal-tracker-alternative"

      expect(response.body).to match(/pivotal-tracker-logo[^"]*\.svg/)
      expect(response.body).not_to include('fill="#4A9187"')
    end

    it "uses small-logo-black.png image_tag for the LiteTracker icon" do
      get "/pivotal-tracker-alternative"

      expect(response.body).to match(/small-logo-black[^"]*\.png/)
      expect(response.body).not_to include('bg-[#1a1a1a]')
    end
  end
end
