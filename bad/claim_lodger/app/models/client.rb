class Client < ActiveRecord::Base
  has_many :claims

  def has_expired_policy?
    # logic here
  end

  def travelled_to_uncovered_location?
    # logic here
  end

  def under_age?
    # logic here
  end
end
