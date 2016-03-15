FactoryGirl.define do
  factory :skill do
    association :user
    title {Faker::Company.buzzword}
  end
end
