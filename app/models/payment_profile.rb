class PaymentProfile < ApplicationRecord
  belongs_to :user
  has_many :charges
end
