class Grade < ApplicationRecord
  has_many :grade_learning_paths
  has_many :learning_paths, through: :grade_learning_paths

  validates :title, :grade_number, presence: true
  validates :grade_number, uniqueness: true
end
