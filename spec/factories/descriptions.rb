FactoryGirl.define do 
  factory :description do 
    detail Faker::Company.bs
    # association :user
    # association :resume_asset
    # association :describing, factory: :experience
  end
end