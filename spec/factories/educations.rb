FactoryGirl.define do
  factory :education do
    association :user
    institution_name {Faker::University.name}
    completion {Faker::Date.between(5.years.ago, Date.today)}
    description {Faker::Company.bs}
    focus {"Studies"}
    location {Faker::Address.city}
  end
end
