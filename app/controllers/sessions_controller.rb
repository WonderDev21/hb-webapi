class SessionsController < Devise::SessionsController
  before_action :rewrite_user_param, only: %i[create]
  clear_respond_to
  respond_to :json

  def create
    self.resource = User.find_by_email(sign_in_params[:email])
    if resource && resource.valid_password?(sign_in_params[:password])
      sign_in(resource_name, resource)
      token = Token.new(jwt_token, Time.zone.now)
    end
    render_resource(token, status: :created)
  end

  private

  def jwt_token
    request.env['warden-jwt_auth.token']
  end

  def rewrite_user_param
    request.params['user'] = sign_in_params.to_hash
  end

  def sign_in_params
    restify_param(:token)
      .require(:token)
      .permit(:email, :password)
  end
end
