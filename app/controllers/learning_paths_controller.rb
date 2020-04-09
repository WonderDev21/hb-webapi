class LearningPathsController < ApplicationController
  def index
    learning_paths = LearningPath.all
    render_resources(learning_paths, status: :ok)
  end

  def grades
    learning_path = LearningPath.find(params[:id])
    render_resources(learning_path.grades, status: :ok)
  end
end
