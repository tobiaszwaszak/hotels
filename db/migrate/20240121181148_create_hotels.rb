class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.integer "destination_id"
      t.jsonb "location"
      t.jsonb "amenities"
      t.jsonb "images"
      t.string "booking_conditions", array: true
      t.string "external_id"
      t.string "name"
      t.text "description"

      t.timestamps

      t.index ["destination_id"], name: "index_hotels_on_destination_id"
      t.index ["external_id"], name: "index_hotels_on_external_id", unique: true
    end
  end
end
