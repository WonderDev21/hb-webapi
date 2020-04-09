FactoryBot.define do
  factory :user do
    email { 'john.doe@worldtechmakers.com' }
    first_name { 'John' }
    last_name { 'Doe' }
    age { 15 }
    city { 'Denver' }
    terms_accepted { true }
    password { 'password1$' }
    password_confirmation { 'password1$' }
    role { 'Student' }

    factory :invalid_user do
      first_name { nil }
    end

    factory :user_with_image do
      image_url { 'https://heartbit.amazonaws.com/users/1.png' }
    end
  end
end
