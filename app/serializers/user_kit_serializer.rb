class UserKitSerializer
  include FastJsonapi::ObjectSerializer

  attributes :funding_source

  has_one :kit
end
