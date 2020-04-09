class TeacherProgramSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :image_url, :resource_url
end
