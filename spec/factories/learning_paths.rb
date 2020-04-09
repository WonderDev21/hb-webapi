FactoryBot.define do
  factory :learning_path do
    title { 'Introduction to STEAM' }
    price_in_cents { '583' }
    video_intro { 'https://heartbit.amazonaws.com/learning_path/1.mp4' }
    description { 'Take your analysis to the next level with General Assembly.' }
    image_url { 'https://heartbit.amazonaws.com/learning_path/1.png' }
  end
end
