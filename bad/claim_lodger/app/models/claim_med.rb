# Medical Claim
class ClaimMED < Claim
  def amount
    client.under_age? ? 5000 : 1000
  end

  def code
    'MED'
  end

  def check_eligiblity
    super
    add_error_if_dental_services
  end

  private

  def add_error_if_dental_services
    if client.has_dental_checkup?
      errors.add :base, 'Dental checkup is not covered'
    end
  end
end