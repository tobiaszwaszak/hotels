require "rails_helper"

describe Serializers::Acme do
  subject(:serialized) { described_class.new.call(input) }
  let(:input) do
    {
      "Id" => "iJhz",
      "DestinationId" => 5432,
      "Name" => "Beach Villas Singapore",
      "Latitude" => 1.264751,
      "Longitude" => 103.824006,
      "Address" => " 8 Sentosa Gateway, Beach Villas ",
      "City" => "Singapore",
      "Country" => "SG",
      "PostalCode" => "098269",
      "Description" => "  This 5 star hotel is located on the coastline of Singapore.",
      "Facilities" => ["Pool","BusinessCenter","WiFi ","DryCleaning"," Breakfast"]
    }
  end

  let(:output) do
    {
      "amenities" => {
        "general"=>["Pool", "BusinessCenter", "WiFi", "DryCleaning", "Breakfast"],
        "room"=>[]
      },
    "booking_conditions" => [],
    "description" => "This 5 star hotel is located on the coastline of Singapore.",
    "destination_id" => 5432,
    "external_id" => "iJhz",
    "images" => [],
    "location" => {
      "address"=>"8 Sentosa Gateway, Beach Villas",
      "city"=>"Singapore",
      "country"=>"SG",
      "lat"=>1.264751,
      "lng"=>103.824006
    },
    "name" => "Beach Villas Singapore"
   }
  end

  it "serializes the input" do
    expect(serialized).to eq(output)
  end
end
