require "rails_helper"
require "webmock/rspec"

RSpec.describe "hotels", type: :request do
  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia")
      .to_return(body: File.read("./spec/fixtures/patagonia.json"), status: 200)
    stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies")
      .to_return(body: File.read("./spec/fixtures/paperflies.json"), status: 200)
      stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme")
      .to_return(body: File.read("./spec/fixtures/acme.json"), status: 200)
  end

  describe "GET /hotels" do
    it "returns a success code" do
      get "/hotels"
      expect(response.status).to eq(200)
    end

    it "returns a list of hotels" do
      get "/hotels"
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it "has the correct keys" do
      get "/hotels"
      expect(JSON.parse(response.body).first.keys).to eq([
        "id",
        "destination_id",
        "name",
        "location",
        "description",
        "amenities",
        "images",
        "booking_conditions"
      ])
    end

    context "when destination_id is provided" do
      it "returns a list of hotels" do
        get "/hotels", params: {destination_id: 1122}
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end

    context "when hotel_ids is provided" do
      it "returns a list of hotels" do
        get "/hotels", params: {hotel_ids: "iJhz,f8c9"}
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end
  end
end
