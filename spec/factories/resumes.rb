FactoryGirl.define do 
  factory :resume do 
    association :user
    target_job "some job"
  end
end