require "rails_helper"

describe Actions::Hotels::Import do
  subject(:action)  { described_class.new.call }
  let(:repository) { instance_double("Repositories::Hotels", delete_all: spy, create: spy) }

  before do
    allow(Repositories::Hotels).to receive(:new).and_return(repository)

    WebMock.disable_net_connect!(allow_localhost: true)
    stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia")
      .to_return(body: File.read("./spec/fixtures/patagonia.json"), status: 200)
    stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies")
      .to_return(body: File.read("./spec/fixtures/paperflies.json"), status: 200)
      stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme")
      .to_return(body: File.read("./spec/fixtures/acme.json"), status: 200)
  end

  it "calls the repository" do
    expect(repository).to receive(:delete_all)
    expect(repository).to receive(:create)
    action
  end
end
