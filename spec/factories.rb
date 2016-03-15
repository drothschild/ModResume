FactoryGirl.define do


  factory :user do
    sequence(:first_name) {|n| "#{n}dobe"}
    last_name "boo"
    email {"#{first_name}@fakemail.com"}
    password "password"
    phone_number "323-240-0224"
  end

  factory :resume do
    target_job "Astronaut"
  end


#   factory :skills do
#     title "Gives great hugs"
#     user_id 22
#   end

end
