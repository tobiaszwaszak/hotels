module Serializers
  class Paperflies < Base
    def call(hotel)
      {
        'external_id' => hotel['hotel_id'],
        'destination_id' => hotel['destination_id'],
        'name' => hotel['hotel_name'],
        'location' => {
          'address' => hotel.dig('location', 'address')&.strip,
          'country' => hotel.dig('location', 'country')&.strip
        },
        'description' => clean_description(hotel['details']),
        'amenities' => {
          'general' => format_amenities(hotel.dig('amenities', 'general')),
          'room' => format_amenities(hotel.dig('amenities', 'room'))
        },
        'images' => {
          "rooms" => format_images(hotel.dig('images', 'rooms')),
          "site" => format_images(hotel.dig('images', 'site')),
          "amenities" => format_images(hotel.dig('images', 'amenities'))
        },
        'booking_conditions' => format_booking_conditions(hotel['booking_conditions'])
      }
    end
  end
end
