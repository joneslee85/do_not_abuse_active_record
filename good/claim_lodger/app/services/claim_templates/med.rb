module ClaimTemplates
  class MED
    def initialize(client)
      @client = client
    end

    def attributes
      { code: 'MED', amount: amount }
    end

    private

    def amount
      if @client.underaged?
        5000
      else
        10000
      end
    end
  end
end