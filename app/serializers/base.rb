module Serializers
  class Base
    private

    def clean_description(description)
      description&.gsub(/\s+/, ' ')&.strip
    end

    def format_amenities(amenities)
      return [] unless amenities

      amenities.map(&:strip)
    end

    def format_images(images)
      return [] unless images

      images.map { |img| { 'link' => img['url'], 'description' => img['description'] } }
    end

    def format_booking_conditions(booking_conditions)
      return [] unless booking_conditions

      booking_conditions.map(&:strip)
    end
  end
end
