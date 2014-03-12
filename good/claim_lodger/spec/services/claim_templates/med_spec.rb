require 'lite_spec_helper'
require './app/services/claim_templates/med'

describe ClaimTemplates::MED do
  describe '#attributes' do
    context 'client is underaged' do
      let(:client) { double('client', underaged?: true) }

      specify do
        service = described_class.new(client)
        expect(service.attributes).to eq({ code: 'MED', amount: 5000 })
      end
    end

    context 'client is not underaged' do
      let(:client) { double('client', underaged?: false) }

      specify do
        service = described_class.new(client)
        expect(service.attributes).to eq({ code: 'MED', amount: 10000 })
      end
    end
  end
end