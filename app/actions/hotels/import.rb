module Actions
  module Hotels
    class Import
      SUPPLIERS = {
        patagonia: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia',
        paperflies: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies',
        acme: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'
      }.freeze

      def initialize(suppliers: SUPPLIERS, hotel_repository: Repositories::Hotels.new)
        @suppliers = suppliers
        @hotel_repository = hotel_repository
      end

      def call
        serialized_hotels_data = SUPPLIERS.map do |name, url|
          hotels = fetch_supplier_data(url)
          hotels.map do |hotel|
            Serializers::const_get(name.capitalize).new.call(hotel)
          end
        end

        data_to_save = []

        serialized_hotels_data.flatten.each do |hotel|
          id = hotel['external_id']
          object = {}
          existed_hotel = data_to_save.find { |hotel| hotel['external_id'] == id }
          if existed_hotel.present?
            object = existed_hotel
            hotel.each do |key, value|
              existed_hotel[key] = value if (key == :description) && (value&.length || 0) > (existed_hotel[key]&.length || 0)
              existed_hotel[key] = (existed_hotel[key] | value).uniq if existed_hotel[key].is_a?(Array) && value.is_a?(Array)
            end
          else
            data_to_save << hotel
          end
        end

        Repositories::Hotels.new.delete_all
        Repositories::Hotels.new.create(data_to_save)
      end

      private

      def fetch_supplier_data(supplier_url)
        response = HTTParty.get(supplier_url)
        JSON.parse(response.body) if response.success?
      end
    end
  end
end
