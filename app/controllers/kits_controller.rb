class KitsController < ApplicationController
  def index
    kits = Kit.all
    options = {}
    # options[:include] = [:kit_videos, :outcomes]
    render_resources(kits, status: :ok, options: options)
  end

  def show
    kit = Kit.find(params[:id])
    options = {}
    options[:include] = [:kit_videos, :outcomes]
    render_resource(kit, status: :ok, options: options)
  end

  def create
    kit = Kit.new(kit_params)
    kit.save
    render_resource(kit, status: :created)
  end

  def update
    kit = Kit.find_by(id: params[:id])
    kit.update(kit_params)
    render_resource(kit, status: :ok)
  end

  def destroy
    kit = Kit.find(params[:id])
    kit.destroy
    render_resource(kit, status: :ok)
  end

  private

  def kit_params
    restify_param(:kit)
      .require(:kit)
      .permit(KitForm.permitted_params)
  end
end
