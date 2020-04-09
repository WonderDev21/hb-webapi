class Kit < ApplicationRecord
  has_many :user_kits
  has_many :users, through: :user_kits
  has_many :kit_videos
  has_many :outcomes

  validates_presence_of :name

  def charge_description
    "Kit #{name}"
  end

  def amount
    price_in_cents
  end
end
