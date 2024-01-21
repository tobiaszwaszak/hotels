module Serializers
  class Patagonia < Base
    def call(hotel)
      {
        'external_id' => hotel['id'],
        'destination_id' => hotel['destination'],
        'name' => hotel['name'],
        'location' => {
          'lat' => hotel['lat'],
          'lng' => hotel['lng'],
          'address' => hotel['address']&.strip
        },
        'description' => clean_description(hotel['info']),
        'amenities' => {
          'general' => [],
          'room' => format_amenities(hotel['amenities'])
        },
        'images' => {
          "rooms" => format_images(hotel['images']['rooms']),
          "site" => format_images(hotel['images']['site']),
          "amenities" => format_images(hotel['images']['amenities'])
        },
        'booking_conditions' => []
      }
    end
  end
end
