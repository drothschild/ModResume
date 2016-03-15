FactoryGirl.define do
    factory :user do
      first_name "Joe"
      last_name  "Blow"
      email { "#{first_name}.#{last_name}@example.com".downcase }
      password '123456'
    end

  factory :skills do
    title "Makes computer do things"
    user_id user
  end
end
