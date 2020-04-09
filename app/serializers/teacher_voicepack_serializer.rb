class TeacherVoicepackSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :resource_url
end
