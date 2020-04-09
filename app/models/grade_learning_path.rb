class GradeLearningPath < ApplicationRecord
  belongs_to :grade
  belongs_to :learning_path

  # validates :grade_id, uniqueness: { scope: :learning_path_id }
end
