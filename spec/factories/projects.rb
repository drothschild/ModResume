FactoryGirl.define do 
  factory :project do 
    association :user
    # description "some website"
    # url "www.something.com"
  end
end