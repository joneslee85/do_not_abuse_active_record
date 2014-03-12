require 'lite_spec_helper'
require './app/services/claim_templates/trv'

describe ClaimTemplates::TRV do
  let(:client) { double('client') }

  describe '#attributes' do
    specify do
      service = described_class.new(client)
      expect(service.attributes).to eq({ code: 'TRV', amount: 5000 })
    end
  end
end