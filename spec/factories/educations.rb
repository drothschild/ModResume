name = Faker::StarWars.character
  if name.include? " "
    first_name = name.split(" ").first
    last_name = name.split(" ").last
  else
    first_name = name
    last_name = name
  end
  username = Faker::Internet.user_name("#{first_name} #{last_name}", %w(. _ -))
  new_user = User.create(
    email: Faker::Internet.free_email(username),
    first_name: first_name,
    last_name: last_name,
    phone_number: Faker::PhoneNumber.phone_number,
    password: "hello")



FactoryGirl.define do
  factory :education do
    institution_name {Faker::University.name}
    completion {Faker::Date.between(5.years.ago, Date.today)}
    description {Faker::Company.bs}
    focus {"Studies"}
    location {Faker::Address.city}
    user {new_user}
  end
end

