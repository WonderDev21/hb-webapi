class UserLearningPathSerializer
  include FastJsonapi::ObjectSerializer

  attributes :funding_source

  has_one :learning_path
end
