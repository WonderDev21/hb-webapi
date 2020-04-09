FactoryBot.define do
  factory :kit do
    name { 'Emotion Tech' }
    image_url { 'https://heartbit.amazonaws.com/kits/emotion-tech.png' }
    industry { 'Emotion Tech' }
    difficulty { 3 }
    age { 8 }
    description { 'This is a short description of what is this kit about' }
    video_url { 'https://heartbit.amazonaws.com/kits/emotion-tech.mp4' }
    published { true }
    background { '00FF00' }
    price_in_cents { 1990 }
  end
end
