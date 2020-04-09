class ChaptersController < ApplicationController
  before_action :set_learning_path

  def index
    chapters = @learning_path.chapters
    render_resources(chapters, status: :ok)
  end

  def create
    chapter = @learning_path.chapters.create(chapter_params)
    render_resource(chapter, status: :created)
  end

  def show
    chapter = @learning_path.chapters.find(params[:id])
    render_resource(chapter, status: :ok)
  end

  private

  def chapter_params
    restify_param(:chapter)
      .require(:chapter)
      .permit(:title, :video_url, :chapter_number, :description)
  end

  def set_learning_path
    @learning_path = LearningPath.find(params[:learning_path_id])
  end
end
