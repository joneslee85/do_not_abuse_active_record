class Claim < ActiveRecord::Base
  belongs_to :client

  validates :code, :amount, :client, presence: true
  validate :check_eligiblity

  before_save :set_amount, :set_code

  def set_amount
    raise NotImplementedError, 'Must be implemented in subclass'
  end

  def set_code
    raise NotImplementedError, 'Must be implemented in subclass'
  end

  def check_eligiblity
    add_error_if_policy_is_expired
  end

  private

  def add_error_if_policy_is_expired
    if client.has_expired_policy?
      errors.add :base, "Policy is expired"
    end
  end

end
