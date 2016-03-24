FactoryGirl.define do 
  factory :tagging do 
    association :tag
    association :taggable, :factory => :project
    # description "some website"
    # url "www.something.com"
  end
end