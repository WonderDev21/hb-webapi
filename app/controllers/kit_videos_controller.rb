class KitVideosController < ApplicationController
  before_action :set_kit

  def index
    kit_videos = @kit.kit_videos
    render_resources(kit_videos, status: :ok)
  end

  def create
    kit_video = @kit.kit_videos.create(kit_videos_params)
    render_resource(kit_video, status: :created)
  end

  def show
    kit_video = @kit.kit_videos.find(params[:id])
    render_resource(kit_video, status: :ok)
  end

  private

  def kit_videos_params
    restify_param(:kit_video)
      .require(:kit_video)
      .permit(:title, :video_url, :video_length, :sort_number)
  end

  def set_kit
    @kit = Kit.find(params[:kit_id])
  end
end
