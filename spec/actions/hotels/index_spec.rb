require "rails_helper"

describe Actions::Hotels::Index do
  subject(:action)  { described_class.new.call(params) }
  let(:params) { {} }
  let(:repository) { instance_double("Repositories::Hotels", all: []) }

  before do
    allow(Repositories::Hotels).to receive(:new).and_return(repository)
  end

  it "calls the repository" do
    expect(repository).to receive(:all)
    action
  end

  context "when destination_id is provided" do
    let(:params) { {"destination_id" => 1122} }

    it "calls the repository" do
      expect(repository).to receive(:all_by).with(destination_id: 1122)
      action
    end
  end

  context "when hotel_ids is provided" do
    let(:params) { {"hotel_ids" => "iJhz,f8c9"} }

    it "calls the repository" do
      expect(repository).to receive(:all_by).with(external_id: ["iJhz", "f8c9"])
      action
    end
  end
end
