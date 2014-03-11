# Travel Claim
class ClaimTRV < Claim
  def amount
    2000
  end

  def code
    'TRV'
  end

  def check_eligiblity
    super
    add_error_if_location_is_not_covered
  end

  private

  def add_error_if_location_is_not_covered
    if client.travelled_to_uncovered_location?
      errors.add :base, 'The location is not covered'
    end
  end
end