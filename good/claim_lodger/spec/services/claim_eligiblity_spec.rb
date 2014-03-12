require 'spec_helper'

module ClaimEligibilities
  class DUMMY
    def initialize(client)
      @client = client
    end
  end
end

describe ClaimEligibility do
  let(:client) { Client.new }

  describe '#eligible?' do
    it 'triggers claim eligibility check' do
      expect_any_instance_of(ClaimEligibilities::DUMMY).to receive(:eligible?)
      described_class.new(client, 'DUMMY').eligible?
    end
  end

  describe '#errors' do
    it 'triggers claim eligibility errors' do
      expect_any_instance_of(ClaimEligibilities::DUMMY).to receive(:errors)
      described_class.new(client, 'DUMMY').errors
    end
  end
end