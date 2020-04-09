class RegistrationForm < ApplicationForm
  self.main_model = :user

  attributes :email, :password, :password_confirmation, :first_name,
             :last_name, :age, :city, :role, :terms_accepted, required: true
  attribute :institution

  validates_acceptance_of :terms_accepted
  validates_confirmation_of :password

  before_save :start_registration

  def start_registration
    model.start_registration
  end
end
