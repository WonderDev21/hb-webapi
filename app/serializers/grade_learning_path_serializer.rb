class GradeLearningPathSerializer
  include FastJsonapi::ObjectSerializer

  attributes :learning_path_id, :grade_id
end
