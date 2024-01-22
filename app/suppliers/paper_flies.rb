module Suppliers
  class PaperFlies < Base
    def initialize
      super('https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies', Serializers::Paperflies.new)
    end
  end
end
