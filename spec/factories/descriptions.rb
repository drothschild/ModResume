FactoryGirl.define do 
  factory :description do 
    association :user
    # description "some website"
    # url "www.something.com"
  end
end