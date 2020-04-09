class Chapter < ApplicationRecord
  belongs_to :learning_path

  validates :title, :chapter_number, presence: true
  validates :chapter_number, uniqueness: { scope: :learning_path_id }
end
