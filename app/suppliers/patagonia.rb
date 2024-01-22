module Suppliers
  class Patagonia < Base
    def initialize
      super('https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia', Serializers::Patagonia.new)
    end
  end
end
