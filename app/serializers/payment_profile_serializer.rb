class PaymentProfileSerializer
  include FastJsonapi::ObjectSerializer

  attributes :last4, :brand

  belongs_to :user
end
