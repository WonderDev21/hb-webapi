FactoryBot.define do
  factory :teacher_program do
    name { 'First Year Teacher' }
    image_url { 'https://heartbit.amazonaws.com/teachers/programs/first_year_teacher.png' }
    resource_url { 'https://heartbit.amazonaws.com/teachers/programs/first_year_teacher.pdf' }
  end
end
