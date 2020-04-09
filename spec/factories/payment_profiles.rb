FactoryBot.define do
  factory :payment_profile do
    external_payment_info { { 'stripe_customer_id': 'customer_FX2mrFpqfmNeml' } }
    last4 { 1234 }
    brand { 'Visa' }
  end
end
