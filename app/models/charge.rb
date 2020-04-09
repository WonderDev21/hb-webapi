class Charge < ApplicationRecord
  enum status: %i[paid failed]

  belongs_to :payment_profile
  belongs_to :chargeable, polymorphic: true

  validates_presence_of :unique_id, :amount

  before_validation :set_amount
  before_validation :set_description
  before_validation :set_unique_id

  private

  def set_amount
    self.amount ||= chargeable.amount
  end

  def set_description
    self.description ||= chargeable.charge_description
  end

  def set_unique_id
    self.unique_id ||= SecureRandom.uuid
  end
end
