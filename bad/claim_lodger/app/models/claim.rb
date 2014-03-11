class Claim < ActiveRecord::Base
  belongs_to :client

  validates :code, :amount, :client, presence: true
  validate :check_eligiblity

  before_save :set_amount, :set_code

  def set_amount
    # to be overriden
  end

  def set_code
    # to be overriden
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
