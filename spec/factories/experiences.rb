FactoryGirl.define do
  factory :experience do
    company  {Faker::Company.name}
    title {Faker::Company.profession}
    begin_date {Faker::Date.between(5.years.ago, Date.today)}
    end_date {Faker::Date.between(5.years.ago, Date.today)}
    description {Faker::Company.bs}
    location {Faker::Address.city}
  end
end

