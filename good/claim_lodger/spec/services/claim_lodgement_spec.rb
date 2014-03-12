require 'spec_helper'

describe ClaimLodgement do
  let!(:client) { Client.create!(name: 'Trung Lê') }
  let!(:claim_code) { 'DUMMY' }

  describe '#lodge_claim' do
    before do
      allow(ClaimTemplate).to receive(:new).with(client, claim_code).and_return(double(attributes: { client: client, code: claim_code, amount: 5000 }))
    end

    context 'when client is eligible' do
      before do
        allow(ClaimEligibility).to receive(:new).with(client, claim_code).and_return(double(eligible?: true))
      end

      context 'when claim is successfully saved' do
        it 'creates new claim' do
          expect {
            lodgement = described_class.new(client, claim_code)

            expect(lodgement.lodge_claim).to be == true

            claim = lodgement.claim
            expect(claim.client).to be == client
            expect(claim.amount).to be == 5000
            expect(claim.code).to be == 'DUMMY'
          }.to change { Claim.count }.by(1)
        end
      end

      context 'when claim is failed to save' do
        before do
          errors = ActiveModel::Errors.new(double('claim'))
          errors.add :base, 'Error Message'
          allow_any_instance_of(Claim).to receive(:valid?).and_return(false)
          allow_any_instance_of(Claim).to receive(:errors).and_return(errors)
        end

        it 'does not create new claim' do
          expect {
            lodgement = described_class.new(client, claim_code)

            expect(lodgement.lodge_claim).to be == false

            errors = lodgement.errors
            expect(errors.messages).to be == { base: ['Error Message'] }
          }.not_to change { Claim.count }
        end
      end
    end

    context 'when client is ineligible' do
      before do
        allow(ClaimEligibility).to receive(:new).with(client, claim_code).
          and_return(double(eligible?: false, errors: { base: ['Error Message'] }))
      end

      it 'does not create new claim' do
        expect {
          lodgement = described_class.new(client, claim_code)

          expect(lodgement.lodge_claim).to be == false

          errors = lodgement.errors
          expect(errors.messages).to be == { base: ['Error Message'] }
        }.not_to change { Claim.count }
      end
    end
  end
end