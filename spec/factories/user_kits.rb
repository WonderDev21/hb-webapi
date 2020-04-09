FactoryBot.define do
  factory :user_kit do
    funding_source { 'payment' }
    association :user
    association :kit
  end
end
