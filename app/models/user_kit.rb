class UserKit < ApplicationRecord
  attr_accessor :charge

  enum funding_source: %i[payment]

  belongs_to :user
  belongs_to :kit
  has_one :charge, as: :chargeable

  validates_uniqueness_of :user_id, scope: [:kit_id]
  validates_presence_of :funding_source

  before_validation :ensure_funds_with_payment
  after_save :update_charge, if: ->(user_kit) { user_kit.charge.present? }

  private

  def ensure_funds_with_payment
    if user.payment_profile
      self.charge = ChargeService.new(user.payment_profile, kit).run
      errors.add(:funding_source, 'failed during charge') unless charge.paid?
    else
      errors.add(:funding_source, 'is not set')
    end
  end

  def update_charge
    charge.update!(chargeable: self)
  end
end
