module Repositories
  class Hotels
    class Record < ActiveRecord::Base
      self.table_name = "hotels"
    end

    class Model < Data.define(:id, :destination_id, :name, :location, :description, :amenities, :images, :booking_conditions)
    end

    def all
      Record.all.map { |record| to_model(record) }
    end

    def all_by(filters)
      Record.where(filters).map { |record| to_model(record) }
    end

    def create(params)
      Record.create(params)
    end

    def delete_all
      Record.delete_all
    end

    private

    def to_model(record)
      Model.new(
        id: record.external_id,
        destination_id: record.destination_id,
        name: record.name,
        location: record.location,
        description: record.description,
        amenities: record.amenities,
        images: record.images,
        booking_conditions: record.booking_conditions
      )
    end
  end
end
