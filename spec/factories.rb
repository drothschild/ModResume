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

  factory :experience do
    company 'Nasa'
    title 'Astronaut'
    end_date 'Sat, 26 Sep 2015'
    begin_date 'Sat, 26 Sep 2015'
    description 'Space work'
    location 'space'
  end

  factory :education do
    institution_name 'Nasa University'
    focus 'Space study'
    description 'Space work'
    location 'USA'
    completion 'Sat, 26 Sep 2015'

  end

#   factory :skills do
#     title "Gives great hugs"
#     user_id 22
#   end

end
