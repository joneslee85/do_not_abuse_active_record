require 'lite_spec_helper'
require './app/services/claim_eligibility_rules/dental_checkup'

describe ClaimEligibilityRules::DentalCheckup do
  describe '#validate' do
    context 'when checkup is dental' do
      let(:client) { double('client', has_dental_checkup?: true) }

      specify do
        service = described_class.new(client)
        expect(service.validate).to eq({ base: 'Dental checkup is not covered' })
      end
    end
  end
end
