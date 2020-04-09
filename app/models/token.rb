Token = Struct.new(:token, :created_at) do
  def id
    created_at
  end

  def expires_on
    created_at + expires_in
  end

  def expires_in
    Warden::JWTAuth.config.expiration_time
  end

  def errors
    []
  end
end
