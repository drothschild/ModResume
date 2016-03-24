FactoryGirl.define do 
  factory :describing do 
    association :description
    association :describable, :factory => :project
  end
end