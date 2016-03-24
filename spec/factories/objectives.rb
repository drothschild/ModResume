FactoryGirl.define do
  factory :objective do
    association :user
    description {Faker::Company.bs}
  end
end
