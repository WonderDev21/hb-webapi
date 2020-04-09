class GradeLearningPathsController < ApplicationController
  def create
    garde_learning_path = GradeLearningPath.create(grade_learning_path_params)
    render_resource(garde_learning_path, status: :created)
  end

  private

  def grade_learning_path_params
    restify_param(:grade_learning_path)
      .require(:grade_learning_path)
      .permit(:learning_path_id, :grade_id)
  end
end
