require 'lite_spec_helper'
require './app/services/claim_eligibility_rules/policy_expiration'

describe ClaimEligibilityRules::PolicyExpiration do
  describe '#validate' do
    context 'when policy is expired' do
      let(:client) { double('client', has_expired_policy?: true) }

      specify do
        service = described_class.new(client)
        expect(service.validate).to eq({ base: 'Policy has expired' })
      end
    end
  end
end