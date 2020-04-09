class JsonapiFailureApp < Devise::FailureApp
  AUTH_ERROR_RESPONSE = {
    errors: [
      {
        status: '401',
        code: 'unauthorized'
      }
    ]
  }.freeze

  def respond
    if request.format == :json
      json_error_response
    else
      super
    end
  end

  def json_error_response
    self.status = 401
    self.content_type = 'application/vnd.api+json'
    self.response_body = AUTH_ERROR_RESPONSE.to_json
  end
end
