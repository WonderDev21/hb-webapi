class OutcomesController < ApplicationController
  before_action :set_kit

  def index
    outcomes = @kit.outcomes
    render_resources(outcomes, status: :ok)
  end

  def create
    outcome = @kit.outcomes.create(outcomes_params)
    render_resource(outcome, status: :created)
  end

  def show
    outcome = @kit.outcomes.find(params[:id])
    render_resource(outcome, status: :ok)
  end

  private

  def outcomes_params
    restify_param(:outcome)
      .require(:outcome)
      .permit(:title, :icon_url)
  end

  def set_kit
    @kit = Kit.find(params[:kit_id])
  end
end
