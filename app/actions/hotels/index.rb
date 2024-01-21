module Actions
  module Hotels
    class Index
      def call(params)
        destination_id = params["destination_id"]
        hotel_ids = params["hotel_ids"]&.split(',')
        if destination_id.present?
          hotels = Repositories::Hotels.new.all_by(destination_id: destination_id)
        elsif hotel_ids.present?
          hotels = Repositories::Hotels.new.all_by(external_id: hotel_ids)
        else
          hotels = Repositories::Hotels.new.all
        end
      end

      private

      def filter_params(params)
        params.permit(:destination, hotels: [])
      end
    end
  end
end
