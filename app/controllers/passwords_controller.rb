class PasswordsController < Devise::PasswordsController
  prepend_before_action :require_no_authentication, unless: -> { password_params.key?(:current_password) }
  clear_respond_to
  respond_to :json

  def create
    User.send_reset_password_instructions(password_request_params)

    head :no_content
  end

  def update
    if password_params.key?(:current_password)
      current_user.update_with_password(new_password_update_params)
      render_resource(current_user)
    else
      user = User.reset_password_by_token(new_password_reset_params)
      render_resource(user)
    end
  end

  private

  def password_request_params
    password_params.permit(:email)
  end

  def new_password_reset_params
    password_params.permit(:password, :reset_password_token, :password_confirmation)
  end

  def new_password_update_params
    password_params.permit(:password, :current_password, :password_confirmation)
  end

  def password_params
    restify_param(:password).require(:password)
  end
end
