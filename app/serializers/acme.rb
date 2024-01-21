module Serializers
  class Acme < Base
    def call(hotel)
      {
        'external_id' => hotel['Id'],
        'destination_id' => hotel['DestinationId'],
        'name' => hotel['Name'],
        'location' => {
          'lat' => hotel['Latitude'],
          'lng' => hotel['Longitude'],
          'address' => hotel['Address']&.strip,
          'city' => hotel['City']&.strip,
          'country' => hotel['Country']&.strip
        },
        'description' => clean_description(hotel['Description']),
        'amenities' => {
          'general' => format_amenities(hotel['Facilities']),
          'room' => []
        },
        'images' => [],
        'booking_conditions' => []
      }
    end
  end
end
