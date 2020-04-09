class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :amount
end
