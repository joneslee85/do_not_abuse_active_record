module ClaimTemplates
  class TRV
    def initialize(client)
      @client = client
    end

    def attributes
      { code: 'TRV', amount: 5000 }
    end
  end
end