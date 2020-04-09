class LearningPath < ApplicationRecord
  has_many :user_learning_paths
  has_many :users, through: :user_learning_paths
  has_many :chapters
  has_many :grade_learning_paths
  has_many :grades, through: :grade_learning_paths

  validates_presence_of :title

  def charge_description
    "Learnin Path #{title}"
  end

  def amount
    price_in_cents
  end
end
