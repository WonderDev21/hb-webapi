class Ticket < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  validates :issue_type, :contact_type, :email, :subject, :problem, presence: true
end
