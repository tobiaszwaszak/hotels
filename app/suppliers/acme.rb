module Suppliers
  class Acme < Base
    def initialize
      super('https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme', Serializers::Acme.new)
    end
  end
end
