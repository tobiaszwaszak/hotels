require "rails_helper"

describe Actions::Hotels::Import do
  let(:suppliers) do
    [
      Suppliers::Patagonia.new,
      Suppliers::PaperFlies.new,
      Suppliers::Acme.new
    ]
  end

  subject(:action)  { described_class.new(suppliers: suppliers).call }
  let(:repository) { instance_double("Repositories::Hotels", delete_all: spy, create: spy) }
  let(:merge_duplicates) { instance_double("MergeDuplicates", call: spy) }

  before do
    allow(Repositories::Hotels).to receive(:new).and_return(repository)
    allow(MergeDuplicates).to receive(:new).and_return(merge_duplicates)

    WebMock.disable_net_connect!(allow_localhost: true)
    stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia")
      .to_return(body: File.read("./spec/fixtures/patagonia.json"), status: 200)
    stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies")
      .to_return(body: File.read("./spec/fixtures/paperflies.json"), status: 200)
      stub_request(:get, "https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme")
      .to_return(body: File.read("./spec/fixtures/acme.json"), status: 200)
  end

  it "fetches data from suppliers" do
    expect(FetchData).to receive(:new).exactly(3).times.and_call_original
    action
  end

  it "serializes the data" do
    expect(Serializers::Patagonia).to receive(:new).times.and_call_original
    expect(Serializers::Paperflies).to receive(:new).times.and_call_original
    expect(Serializers::Acme).to receive(:new).times.and_call_original
    action
  end

  it "merge duplicates" do
    expect(merge_duplicates).to receive(:call)
    action
  end

  it "calls the repository" do
    expect(repository).to receive(:delete_all)
    expect(repository).to receive(:create)
    action
  end
end
