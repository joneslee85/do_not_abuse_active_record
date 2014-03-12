class ClaimEligibility
  def initialize(client, code)
    @client = client
    @code   = code
    @validator = find_rule_by_code(@code).new(@client)
  end

  def eligible?
    @validator.eligible?
  end

  def errors
    @validator.errors
  end

  private

  def find_rule_by_code(code)
    "ClaimEligibilities::#{code}".constantize
  end
end
