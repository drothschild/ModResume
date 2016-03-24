FactoryGirl.define do 
  factory :tag do 
    association :user
    name "Testing Tag"
  end
end