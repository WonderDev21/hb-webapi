class KitVideoSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :video_url, :video_length, :sort_number
  belongs_to :kit
end
