class User < ApplicationRecord
  include ActiveModel::Transitions
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  belongs_to :language, required: false
  has_many :invited_users, foreign_key: :invited_by_id, class_name: 'User'
  has_one :payment_profile
  has_one :subscription
  has_many :user_kits
  has_many :kits, through: :user_kits
  has_many :user_learning_paths
  has_many :learning_paths, through: :user_learning_paths
  has_many :charges, through: :payment_profile
  has_many :tickets

  validates_presence_of :first_name, :last_name, :age, :city, :role, :terms_accepted
  validates_presence_of :password_confirmation, if: :will_save_change_to_encrypted_password?

  state_machine attribute_name: :registration_state do
    state :register_pending
    state :language_pending
    state :onboarding_completed

    event :start_registration do
      transitions from: :register_pending, to: :language_pending
    end

    event :select_language do
      transitions from: :language_pending, to: :onboarding_completed
    end
  end
end
