# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Website.destroy_all
Tag.destroy_all
Resume.destroy_all
# Resume_asset.destroy_all
Tagging.destroy_all
# Objective.destroy_all
# Skill.destroy_all
# Volunteer.destroy_all
# Experience.destroy_all
# Project.destroy_all
# Education.destroy_all


10.times do 
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

  Website.create(description: "LinkedIn", url: Faker::Internet.url('linkedin.com', "/#{username}"), user_id: new_user.id)
  Website.create(description: "GitHub", url: Faker::Internet.url('github.com', "/#{username}"), user_id: new_user.id)

  rand(0..4).times do 
    Tag.create(user_id: new_user.id, name: Faker::StarWars.planet)
  end

  rand(0..2).times do 
    Tag.create(user_id: new_user.id, name: Faker::StarWars.droid)
  end
end

