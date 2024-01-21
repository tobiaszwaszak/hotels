require "rails_helper"

describe Serializers::Patagonia do
  subject(:serialized) { described_class.new.call(input) }
  let(:input) do
    {
      "id"=>"iJhz",
      "destination"=>5432,
      "name"=>"Beach Villas Singapore",
      "lat"=>1.264751,
      "lng"=>103.824006,
      "address"=>"8 Sentosa Gateway, Beach Villas, 098269",
      "info"=>"Located at the western tip of Resorts World Sentosa",
      "amenities"=>["Aircon","Tv","Coffee machine","Kettle","Hair dryer","Iron","Tub"],
      "images"=>{
        "rooms"=>[
          {"url"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg","description"=>"Double room"},
          {"url"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg","description"=>"Bathroom"}
        ],
        "amenities"=>[
          {"url"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg","description"=>"RWS"},
          {"url"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg","description"=>"Sentosa Gateway"}
        ]
      }
    }
  end

  let(:output) do
    {
      "external_id"=>"iJhz",
      "destination_id"=>5432,
      "name"=>"Beach Villas Singapore",
      "location"=>{"lat"=>1.264751, "lng"=>103.824006, "address"=>"8 Sentosa Gateway, Beach Villas, 098269"},
      "description"=>"Located at the western tip of Resorts World Sentosa",
      "amenities"=>{"general"=>[], "room"=>["Aircon", "Tv", "Coffee machine", "Kettle", "Hair dryer", "Iron", "Tub"]},
      "images"=>
        {
          "rooms"=>[
            {"link"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg", "description"=>"Double room"},
            {"link"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg", "description"=>"Bathroom"}
          ],
          "site"=>[],
          "amenities"=>[
            {"link"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg", "description"=>"RWS"},
            {"link"=>"https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg", "description"=>"Sentosa Gateway"}
          ]
        },
        "booking_conditions"=>[]
  }
  end

  it "serializes the input" do
    expect(serialized).to eq(output)
  end
end
