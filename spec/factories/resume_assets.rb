FactoryGirl.define do
  factory :resume_asset, class: "ResumeAsset" do
    association :resume
    association :buildable, :factory => :project
  end
   
end
