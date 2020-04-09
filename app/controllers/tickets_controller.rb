class TicketsController < ApplicationController
  def index
    tickets = current_user.tickets
    render_resources(tickets, status: :ok)
  end

  def create
    ticket = current_user.tickets.create(tickets_params)
    render_resource(ticket, status: :created)
  end

  private

  def tickets_params
    params.require(:ticket).permit(:issue_type, :contact_type, :email, :subject, :problem, :file)
  end
end
