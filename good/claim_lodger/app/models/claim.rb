class Claim < ActiveRecord::Base
  belongs_to :client

  validates :client, :code, :amount, presence: true
end
