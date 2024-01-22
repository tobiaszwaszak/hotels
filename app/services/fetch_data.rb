class FetchData
  attr_reader :supplier_url

  def initialize(supplier_url)
    @supplier_url = supplier_url
  end

  def call
    response = HTTParty.get(supplier_url)
    JSON.parse(response.body) if response.success?
  end
end
