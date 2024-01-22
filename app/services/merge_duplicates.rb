class MergeDuplicates
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def call
    filtered_data = []
    data.each do |hotel|
      id = hotel['external_id']
      existed_hotel = filtered_data.find { |h| h['external_id'] == id }
      if existed_hotel
        hotel.each do |key, value|
          if key == "description" && (value&.length || 0) > (existed_hotel[key]&.length || 0)
            existed_hotel[key] = value
          elsif existed_hotel[key].is_a?(Array) && value.is_a?(Array)
            existed_hotel[key] = (existed_hotel[key] | value).uniq
          end
        end
      else
        filtered_data << hotel
      end
    end

    filtered_data
  end
end
