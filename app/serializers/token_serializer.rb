class TokenSerializer
  include FastJsonapi::ObjectSerializer

  attributes :token, :created_at, :expires_on, :expires_in
end
