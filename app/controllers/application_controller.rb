class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_resource(resource, status: :ok, serializer_class: nil, options: {})
    if resource
      if resource.errors.empty?
        serializer_class ||= serializer_for(resource)
        render json: serializer_class.new(resource, options), status: status
      else
        render_validation_error(resource)
      end
    else
      render json: { data: nil }, status: status
    end
  end

  def render_resources(resources, status: :ok, serializer_class: nil, options: {})
    if resources.length > 0
      serializer_class ||= serializer_for(resources.first)
      render json: serializer_class.new(resources, options), status: status
    else
      render json: { data: [] }, status: status
    end
  end

  def render_validation_error(resource)
    render json: ErrorSerializer.new(resource), status: :unprocessable_entity
  end

  def render_http_error(status:, code:)
    render json: { errors: [{ status: status.to_s, code: code }] }, status: status
  end

  private

  def serializer_for(resource)
    "#{resource.class}Serializer".constantize
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :role, :terms_accepted])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:age, :city])
  end
end
