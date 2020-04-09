class KitForm < ApplicationForm
  attributes :name, :description, :age, :difficulty, :industry, :image_url,
             :video_url, :published, :background, :price_in_cents, required: true
end
