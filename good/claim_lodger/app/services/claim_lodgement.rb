class ClaimLodgement
  attr_reader :claim, :errors, :client, :code

  def initialize(client, code)
    @client = client
    @claim  = Claim.new
    @errors = ActiveModel::Errors.new(@claim)
    @code   = code
  end

  def lodge_claim
    claim_eligbility = ClaimEligibility.new(client, code)

    if claim_eligbility.eligible?
      create_claim
    else
      create_errors(claim_eligbility.errors)
      false
    end
  end

  private

  def create_claim
    claim_template = ClaimTemplate.new(client, code)
    claim.assign_attributes(claim_template.attributes)

    if !claim.save
      @errors = claim.errors
      false
    else
      true
    end
  end

  def create_errors(errors)
    errors.each do |error|
      key, message = error.to_a.flatten
      @errors.add key, message
    end
  end

end