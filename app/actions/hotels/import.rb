module Actions
  module Hotels
    class Import
      def initialize(suppliers: [], hotel_repository: Repositories::Hotels.new)
        @suppliers = suppliers
        @hotel_repository = hotel_repository
      end

      def call
        serialized_hotels_data = @suppliers.map { |supplier| get_and_serialize_hotels(supplier) }
        data_to_save = MergeDuplicates.new(serialized_hotels_data.flatten).call

        @hotel_repository.delete_all
        @hotel_repository.create(data_to_save)
      end

      private

      def get_and_serialize_hotels(supplier)
        hotels = FetchData.new(supplier.url).call
        hotels.map { |hotel| supplier.serializer.call(hotel) }
      end
    end
  end
end
