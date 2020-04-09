class TicketSerializer
  include FastJsonapi::ObjectSerializer

  attributes :issue_type, :contact_type, :email, :subject, :problem
end
