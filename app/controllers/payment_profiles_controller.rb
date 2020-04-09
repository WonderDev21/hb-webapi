class PaymentProfilesController < ApplicationController
  def show
    render_resource(current_user.payment_profile, status: :ok)
  end

  def update
    current_user.build_payment_profile unless current_user.payment_profile
    current_user.payment_profile.update(payment_profile_params)
    render_resource(current_user.payment_profile, status: :created)
  end

  private

  def payment_profile_params
    restify_param(:payment_profile)
      .require(:payment_profile)
      .permit(:last4, :brand, external_payment_info: {})
  end
end
