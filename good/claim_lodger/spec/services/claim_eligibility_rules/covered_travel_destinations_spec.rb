require 'lite_spec_helper'
require './app/services/claim_eligibility_rules/covered_travel_destinations'

describe ClaimEligibilityRules::CoveredTravelDestinations do
  describe '#validate' do
    context 'when destination is not covered' do
      let(:client) { double('client', travelled_to_uncovered_location?: true) }

      specify do
        service = described_class.new(client)
        expect(service.validate).to eq({ base: 'The location is not covered' })
      end
    end
  end
end