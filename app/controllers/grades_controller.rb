class GradesController < ApplicationController

  def index
    grades = Grade.all
    render_resources(grades, status: :ok)
  end

  def create
    grade = Grade.create(grade_params)
    render_resource(grade, status: :created)
  end

  def show
    grade = Grade.find(params[:id])
    render_resource(grade, status: :ok)
  end

  def learning_paths
    grade = Grade.find_by(grade_number: params[:id])
    options = {}
    options[:include] = [:chapters]
    render_resources(grade.learning_paths, status: :ok, options: options)
  end

  private

  def grade_params
    restify_param(:grade)
      .require(:grade)
      .permit(:title, :grade_number)
  end
end
