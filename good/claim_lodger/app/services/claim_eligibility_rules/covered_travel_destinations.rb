module ClaimEligibilityRules
  class CoveredTravelDestinations
    def initialize(client)
      @client = client
    end

    def validate
      if @client.travelled_to_uncovered_location?
        { base: 'The location is not covered' }
      end
    end
  end
end