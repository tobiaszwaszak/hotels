require "rails_helper"

describe Serializers::Paperflies do
  subject(:serialized) { described_class.new.call(input) }
  let(:input) do
    {
      "hotel_id"=>"iJhz",
      "destination_id"=>5432,
      "hotel_name"=>"Beach Villas Singapore",
      "location"=>{
        "address"=>"8 Sentosa Gateway, Beach Villas, 098269",
        "country"=>"Singapore"
      },
      "details"=>"Surrounded by tropical gardens"
    }
  end

  let(:output) do
    {
      "external_id"=>"iJhz",
      "destination_id"=>5432,
      "name"=>"Beach Villas Singapore",
      "location"=>{"address"=>"8 Sentosa Gateway, Beach Villas, 098269", "country"=>"Singapore"},
      "description"=>"Surrounded by tropical gardens",
      "amenities"=>{"general"=>[], "room"=>[]},
      "images"=>{"rooms"=>[], "site"=>[], "amenities"=>[]},
      "booking_conditions"=>[]
    }
  end

  it "serializes the input" do
    expect(serialized).to eq(output)
  end
end
