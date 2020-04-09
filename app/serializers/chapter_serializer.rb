class ChapterSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :video_url, :chapter_number, :description
end
