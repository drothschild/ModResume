FactoryGirl.define do
  factory :project do
    title {Faker::Hacker.ingverb}
    description {Faker::Hacker.say_something_smart}
  end
end

