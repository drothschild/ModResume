FactoryGirl.define do 
  factory :user do 
    first_name "Han"
    last_name "Solo"
    sequence(:email) { |n| "test#{n}@test.com" }
    phone_number "555-555-5555"
    password "testing"
    confirmed_at '2016-03-14'
  end
end
