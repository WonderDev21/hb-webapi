class GradeSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :grade_number
end
