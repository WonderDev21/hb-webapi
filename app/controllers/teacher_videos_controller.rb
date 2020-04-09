class TeacherVideosController < ApplicationController
  def index
    videos = TeacherVideo.all
    render_resources(videos, status: :ok)
  end
end
