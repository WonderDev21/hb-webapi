class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource.model, status: :created)
  end

  private

  def build_resource(sign_up_params)
    self.resource = RegistrationForm.new(User.new)
    resource.submit(sign_up_params)
  end

  def sign_up_params
    restify_param(:user)
      .require(:user)
      .permit(RegistrationForm.permitted_params)
  end
end
