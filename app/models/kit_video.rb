class KitVideo < ApplicationRecord
  belongs_to :kit

  validates_presence_of :title, :video_url, :video_length, :sort_number
end
