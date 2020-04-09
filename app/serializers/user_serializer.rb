class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :email, :first_name, :last_name, :age, :city, :image_url, :role, :address, :registration_state, :institution, :industry, :url, :country, :invitation_accepted_at

  has_one :language

  attributes :school_code_verified do |object|
    object.school_code_verified_at.present?
  end
end
