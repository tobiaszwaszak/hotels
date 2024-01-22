module Actions
  module Hotels
    class Index
      def call(params)
        filters = {}
        filters[:destination_id] = params["destination"] if params["destination"].present?
        filters[:external_id] = params["hotels"] if params["hotels"].present?

        if filters[:destination_id].present? || filters[:external_id].present?
          Repositories::Hotels.new.all_by(filters.to_h)
        else
          Repositories::Hotels.new.all
        end
      end

      private

      def filter_params(params)
        params.permit(:destination, hotels: [])
      end
    end
  end
end
