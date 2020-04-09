class Outcome < ApplicationRecord
  belongs_to :kit

  validates_presence_of :title, :icon_url
end
