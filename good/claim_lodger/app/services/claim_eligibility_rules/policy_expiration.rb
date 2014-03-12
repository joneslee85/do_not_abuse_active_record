module ClaimEligibilityRules
  class PolicyExpiration
    def initialize(client)
      @client = client
    end

    def validate
      if @client.has_expired_policy?
        { base: 'Policy has expired' }
      end
    end
  end
end