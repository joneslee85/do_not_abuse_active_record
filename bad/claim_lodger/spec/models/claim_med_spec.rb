require 'spec_helper'

describe ClaimMED do
  describe 'create new claim' do
    let!(:client) { Client.create!(name: 'Trung Le') }

    context 'when met all eligibility rules' do
      before do
        allow(client).to receive(:has_dental_checkup?).and_return(false)
        allow(client).to receive(:has_expired_policy?).and_return(false)
      end

      context 'when client is under age' do
        before do
          allow(client).to receive(:under_age?).and_return(true)
        end

        specify do
          claim = ClaimMED.new(client: client)
          expect { claim.save }.to change { Claim.count }.by(1)

          expect(claim).to be_valid
          expect(claim.amount).to be == 5000
          expect(claim.code).to be == 'MED'
        end
      end

      context 'when client is not under age' do
        before do
          allow(client).to receive(:under_age?).and_return(false)
        end

        specify do
          claim = ClaimMED.new(client: client)
          expect { claim.save }.to change { Claim.count }.by(1)

          expect(claim).to be_valid
          expect(claim.amount).to be == 1000
          expect(claim.code).to be == 'MED'
        end
      end
    end

    context 'when policy is expired' do
      specify do
        allow(client).to receive(:has_dental_checkup?).and_return(false)
        allow(client).to receive(:has_expired_policy?).and_return(true)

        claim = ClaimMED.new(client: client)
        expect { claim.save }.not_to change { Claim.count }

        expect(claim).to be_invalid
        expect(claim.errors.to_a).to include('Policy is expired')
      end
    end

    context 'when client has dental checkup' do
      specify do
        allow(client).to receive(:has_dental_checkup?).and_return(true)
        allow(client).to receive(:has_expired_policy?).and_return(false)

        claim = ClaimMED.new(client: client)
        expect { claim.save }.not_to change { Claim.count }

        expect(claim).to be_invalid
        expect(claim.errors.to_a).to include('Dental checkup is not covered')
      end
    end
  end
end
