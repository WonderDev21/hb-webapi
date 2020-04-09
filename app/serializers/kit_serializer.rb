class KitSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :image_url, :industry, :difficulty, :age, :description, :video_url, :published, :background, :price_in_cents
  has_many :kit_videos
  has_many :outcomes
end
