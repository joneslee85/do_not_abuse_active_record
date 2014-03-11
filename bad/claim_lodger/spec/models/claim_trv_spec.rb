require 'spec_helper'

describe ClaimTRV do
  describe 'create new claim' do
    let!(:client) { Client.create!(name: 'Trung Le') }

    context 'when met all eligibility rules' do
      specify do
        allow(client).to receive(:travelled_to_uncovered_location?).and_return(false)
        allow(client).to receive(:has_expired_policy?).and_return(false)

        claim = ClaimTRV.new(client: client)
        expect { claim.save }.to change { Claim.count }.by(1)

        expect(claim).to be_valid
        expect(claim.amount).to be == 2000
        expect(claim.code).to be == 'TRV'
      end
    end

    context 'when policy is expired' do
      specify do
        allow(client).to receive(:travelled_to_uncovered_location?).and_return(false)
        allow(client).to receive(:has_expired_policy?).and_return(true)

        claim = ClaimTRV.new(client: client)
        expect { claim.save }.not_to change { Claim.count }

        expect(claim).to be_invalid
        expect(claim.errors.to_a).to include('Policy is expired')
      end
    end

    context 'when travelled to uncovered location' do
      specify do
        allow(client).to receive(:travelled_to_uncovered_location?).and_return(true)
        allow(client).to receive(:has_expired_policy?).and_return(false)

        claim = ClaimTRV.new(client: client)
        expect { claim.save }.not_to change { Claim.count }

        expect(claim).to be_invalid
        expect(claim.errors.to_a).to include('The location is not covered')
      end
    end
  end
end
