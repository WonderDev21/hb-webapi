require 'devise/jwt/test_helpers'

module RequestsHelper
  DEFAULT_HEADERS = {
    'CONTENT_TYPE': 'application/vnd.api+json',
    'HTTP_ACCEPT': 'application/vnd.api+json'
  }.freeze

  def get_json(path, headers = {})
    get(path, headers: headers.merge(DEFAULT_HEADERS))
  end

  def post_json(path, params = {}, headers = {})
    post(path, params: params.to_json, headers: headers.merge(DEFAULT_HEADERS))
  end

  def put_json(path, params = {}, headers = {})
    put(path, params: params.to_json, headers: headers.merge(DEFAULT_HEADERS))
  end

  def patch_json(path, params = {}, headers = {})
    patch(path, params: params.to_json, headers: headers.merge(DEFAULT_HEADERS))
  end

  def delete_json(path, params = {}, headers = {})
    delete(path, params: params.to_json, headers: headers.merge(DEFAULT_HEADERS))
  end

  def auth_headers(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end

  def json_response
    JSON.parse(response.body)
  end
end
