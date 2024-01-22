require "rails_helper"

describe MergeDuplicates do
  subject(:merge_duplicates) { described_class.new(input).call }

  let(:input) { {} }

  context "when there are no data" do
    it "returns empty array" do
      expect(merge_duplicates).to eq([])
    end
  end

  context "when there are no duplicates" do
    let(:input) do
      [
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
      ]
    end

    it "returns the same array" do
      expect(merge_duplicates).to eq(input)
    end
  end

  context "when there are duplicates" do
    context "when are exactly the same" do
      let(:input) do
        [
          {
            "Id" => "iJhz",
            "DestinationId" => 5432,
            "Name" => "Beach Villas Singapore",
          },
          {
            "Id" => "iJhz",
            "DestinationId" => 5432,
            "Name" => "Beach Villas Singapore",
          }
        ]
      end

      it "returns array with one object" do
        expect(merge_duplicates.size).to eq(1)
      end

      it "has values for first hash" do
        expect(merge_duplicates.first["Id"]).to eq("iJhz")
        expect(merge_duplicates.first["DestinationId"]).to eq(5432)
        expect(merge_duplicates.first["Name"]).to eq("Beach Villas Singapore")
      end
    end

    context "when there is description to update" do
      let(:input) do
        [
          {
            "Id" => "iJhz",
            "DestinationId" => 5432,
            "Name" => "Beach Villas Singapore",
          },
          {
            "Id" => "iJhz",
            "DestinationId" => 5432,
            "Name" => "Beach Villas Singapore",
            "description" => "This 5 star hotel",
          }
        ]
      end

      it "update description" do
        expect(merge_duplicates.first["Id"]).to eq("iJhz")
        expect(merge_duplicates.first["description"]).to eq("This 5 star hotel")
      end
    end

    context "when key is already fullfiled" do
      let(:input) do
        [
          {
            "Id" => "iJhz",
            "DestinationId" => 5432,
            "Name" => "Beach Villas Singapore",
          },
          {
            "Id" => "iJhz",
            "DestinationId" => 5432,
            "Name" => "Beach Villas Singapore with view",
          }
        ]
      end

      it "does not update description" do
        expect(merge_duplicates.first["Id"]).to eq("iJhz")
        expect(merge_duplicates.first["Name"]).to eq("Beach Villas Singapore")
      end
    end

    context "when there is array to update" do
      let(:input) do
        [
          {
            "Id" => "iJhz",
            "Facilities" => ["Pool","BusinessCenter","WiFi ","DryCleaning"]
          },
          {
            "Id" => "iJhz",
            "Facilities" => [" Breakfast"]}
        ]
      end

      it "merge arrays" do
        expect(merge_duplicates.first["Facilities"]).to eq(["Pool","BusinessCenter","WiFi ","DryCleaning"," Breakfast"])
      end

      context "when there are duplicates in array" do
        let(:input) do
          [
            {
              "Id" => "iJhz",
              "Facilities" => ["Pool"]
            },
            {
              "Id" => "iJhz",
              "Facilities" => ["Pool"]}
          ]
        end

        it "ignore duplicates" do
          expect(merge_duplicates.first["Facilities"]).to eq(["Pool"])
        end
      end
    end

    context "when there is hash to update" do
      context "when first hash has empty key" do
        let(:input) do
          [
            {
              "Id" => "iJhz",
              "DestinationId" => 5432,
              "location" => {},
            },
            {
              "Id" => "iJhz",
              "DestinationId" => 5432,
              "location" => {"lat"=>1.264751, "lng"=>103.824006, "address"=>"8 Sentosa Gateway, Beach Villas", "city"=>"Singapore", "country"=>"SG"},
            }
          ]
        end

        it "update hash" do
          expect(merge_duplicates.first["location"]).to eq(
            {"lat"=>1.264751, "lng"=>103.824006, "address"=>"8 Sentosa Gateway, Beach Villas", "city"=>"Singapore", "country"=>"SG"}
          )
        end
      end

      context "when first hash has values" do
        let(:input) do
          [
            {
              "Id" => "iJhz",
              "DestinationId" => 5432,
              "amenities"=>{"general"=>["Pool", "BusinessCenter"], "room"=>[]},
            },
            {
              "Id" => "iJhz",
              "DestinationId" => 5432,
              "amenities"=>{"general"=>["WiFi", "DryCleaning", "Breakfast"], "room"=>["Fridge"]},
            }
          ]
        end

        it "update hash" do
          expect(merge_duplicates.first["amenities"]).to eq(
            {"general"=>["Pool", "BusinessCenter", "WiFi", "DryCleaning", "Breakfast"], "room"=>["Fridge"]}
          )
        end
      end
    end
  end
end
