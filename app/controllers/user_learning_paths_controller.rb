class UserLearningPathsController < ApplicationController
  def index
    user_learning_paths = current_user.user_learning_paths
    render_resources(user_learning_paths, status: :ok, options: { include: [:learning_path] })
  end

  def create
    user_learning_path = current_user.user_learning_paths.create(user_learning_path_params)
    render_resource(user_learning_path, status: :created)
  end

  private

  def user_learning_path_params
    restify_param(:user_learning_path)
      .require(:user_learning_path)
      .permit(:learning_path_id, :funding_source)
  end
end
