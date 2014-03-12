require 'spec_helper'

describe ClaimEligibilities::MED do
  let!(:client) { double('client') }

  describe '#eligible?' do
    it %{ triggers following eligibility rules:
      * check for policy expiration
      * check if checkup is dental
    } do
      expect_any_instance_of(ClaimEligibilityRules::PolicyExpiration).to receive(:validate).once
      expect_any_instance_of(ClaimEligibilityRules::DentalCheckup).to receive(:validate).once
      described_class.new(client).eligible?
    end

    context 'when there is no errors' do
      it 'returns true' do
        allow_any_instance_of(described_class).to receive(:validate_rules).and_return([])

        expect(described_class.new(client).eligible?).to eq true
      end
    end

    context 'when there are errors' do
      it 'returns true' do
        allow_any_instance_of(described_class).to receive(:validate_rules).and_return([{ error: 'An error has occured '}])

        expect(described_class.new(client).eligible?).to eq false
      end
    end
  end

end