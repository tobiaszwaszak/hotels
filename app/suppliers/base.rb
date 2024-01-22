module Suppliers
  class Base
    attr_reader :url, :serializer

    def initialize(url, serializer)
      @url = url
      @serializer = serializer
    end
  end
end
