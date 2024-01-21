module Serializers
  class Paperflies < Base
    def process_hotel(hotel)
      {
        'id' => hotel['hotel_id'],
        'destination_id' => hotel['destination_id'],
        'name' => hotel['hotel_name'],
        'location' => {
          'address' => hotel['location']['address']&.strip,
          'country' => hotel['location']['country']&.strip
        },
        'description' => clean_description(hotel['details']),
        'amenities' => {
          'general' => format_amenities(hotel['amenities']['general']),
          'room' => format_amenities(hotel['amenities']['room'])
        },
        'images' => {
          "rooms" => format_images(hotel['images']['rooms']),
          "site" => format_images(hotel['images']['site']),
          "amenities" => format_images(hotel['images']['amenities'])
        },
        'booking_conditions' => format_booking_conditions(hotel['booking_conditions'])
      }
    end
  end
end
