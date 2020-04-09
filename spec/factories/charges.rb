FactoryBot.define do
  factory :charge do
    association :payment_profile
    amount { 9900 }
    description { 'Kit' }
    unique_id { SecureRandom.uuid }
  end
end
