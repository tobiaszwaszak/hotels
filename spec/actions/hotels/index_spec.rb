# spec/actions/hotels/index_spec.rb

require "rails_helper"

describe Actions::Hotels::Index do
  subject(:action) { described_class.new.call(params) }
  let(:repository) { instance_double("Repositories::Hotels", all: [],all_by: []) }
  let(:params) { ActionController::Parameters.new({}) }

  before do
    allow(Repositories::Hotels).to receive(:new).and_return(repository)
  end

  it "calls the repository" do
    expect(repository).to receive(:all)
    action
  end

  context "when destination_id is provided" do
    let(:params) { ActionController::Parameters.new({ "destination" => 1122 }) }

    it "calls the repository with destination_id" do
      expect(repository).to receive(:all_by).with({ destination_id: 1122 })
      action
    end
  end

  context "when hotel_ids is provided" do
    let(:params) { ActionController::Parameters.new({ "hotels" => ["iJhz", "f8c9"] }) }

    it "calls the repository with hotel_ids" do
      expect(repository).to receive(:all_by).with({ external_id: ["iJhz", "f8c9"] })
      action
    end
  end

  context "when both destination_id and hotel_ids are provided" do
    let(:params) { ActionController::Parameters.new({ "destination" => 1122, "hotels" => ["iJhz", "f8c9"] }) }

    it "calls the repository with both destination_id and hotel_ids" do
      expect(repository).to receive(:all_by).with({ destination_id: 1122, external_id: ["iJhz", "f8c9"] })
      action
    end
  end
end
