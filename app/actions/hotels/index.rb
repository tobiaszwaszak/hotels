module Actions
  module Hotels
    class Index
      SUPPLIERS = {
        patagonia: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia',
        paperflies: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies',
        acme: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'
      }.freeze

      def call(params)
        destination_id = params["destination_id"]
        hotel_ids = params["hotel_ids"]&.split(',')
        data = SUPPLIERS.map do |name, url|
          response = fetch_supplier_data(url)
          Serializers.const_get(name.capitalize).new(response).call
        end

        if destination_id
          data = data.map do |hotels|
            hotels.select { |hotel| hotel['destination_id'].to_s == destination_id }
          end
        elsif hotel_ids
          data = data.map do |hotels|
            hotels.select { |hotel| hotel_ids.include?(hotel['id']) }
          end
        end

        merge_hotel_data(data)
      end

      private

      def filter_params(params)
        params.permit(:destination, hotels: [])
      end

      def fetch_supplier_data(supplier_url)
        response = HTTParty.get(supplier_url)
        JSON.parse(response.body) if response.success?
      end

      def merge_hotel_data(hotels_data)
        hotels_data.flatten.uniq { |hotel| hotel['id'] }
      end
    end
  end
end
