FactoryGirl.define do 
  factory :website do 
    association :user
    description "some website"
    url "www.something.com"
  end
end