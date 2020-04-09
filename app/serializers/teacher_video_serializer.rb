class TeacherVideoSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :resource_url
end
