class UserLearningPath < ApplicationRecord
  attr_accessor :charge

  enum funding_source: %i[payment school_code]

  belongs_to :user
  belongs_to :learning_path
  has_one :charge, as: :chargeable

  validates_uniqueness_of :user_id, scope: [:learning_path_id]
  validates_presence_of :funding_source

  before_validation :ensure_funds_with_payment
  after_save :update_charge, if: ->(user_learning_path) { user_learning_path.charge.present? }

  private

  def ensure_funds_with_payment
    return true if funding_source == 'school_code'
    if user.payment_profile
      self.charge = ChargeService.new(user.payment_profile, learning_path).run
      errors.add(:funding_source, 'failed during charge') unless charge.paid?
    else
      errors.add(:funding_source, 'is not set')
    end
  end

  def update_charge
    charge.update!(chargeable: self)
  end
end
