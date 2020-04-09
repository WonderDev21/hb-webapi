require 'markdown_renderer'

class LearningPathSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :image_url, :price_in_cents, :video_intro

  has_many :chapters

  attribute :description do |learning_path|
    MarkdownRenderer.new.render(learning_path.description)
  end
end
