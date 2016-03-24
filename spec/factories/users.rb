FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    phone_number "555-555-5555"
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
  end
end
