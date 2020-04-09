class UserKitsController < ApplicationController
  def index
    user_kits = current_user.user_kits
    render_resources(user_kits, status: :ok, options: { include: [:kit] })
  end

  def create
    user_kit = current_user.user_kits.create(user_kit_params)
    render_resource(user_kit, status: :created)
  end

  private

  def user_kit_params
    restify_param(:user_kit)
      .require(:user_kit)
      .permit(:kit_id, :funding_source)
  end
end
