FactoryBot.define do
  factory :user_learning_path do
    funding_source { 'payment' }
    association :user
    association :learning_path
  end
end
