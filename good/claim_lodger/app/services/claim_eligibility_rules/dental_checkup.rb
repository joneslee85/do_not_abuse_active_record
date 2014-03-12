module ClaimEligibilityRules
  class DentalCheckup
    def initialize(client)
      @client = client
    end

    def validate
      if @client.has_dental_checkup?
        { base: 'Dental checkup is not covered' }
      end
    end
  end
end