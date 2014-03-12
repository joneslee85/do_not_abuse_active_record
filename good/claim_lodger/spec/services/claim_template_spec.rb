require 'spec_helper'

module ClaimTemplates
  class DUMMY
    def initialize(client)
      @client = client
    end
  end
end

describe ClaimTemplate do
  let(:client) { Client.new }

  describe '#attributes' do
    it 'triggers template attributes' do
      expect_any_instance_of(ClaimTemplates::DUMMY).to receive(:attributes).and_return({})
      described_class.new(client, 'DUMMY').attributes
    end
  end
end