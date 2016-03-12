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
ResumeAsset.destroy_all
Tagging.destroy_all
Objective.destroy_all
Skill.destroy_all
Volunteering.destroy_all
Experience.destroy_all
Project.destroy_all
Education.destroy_all


10.times do
  # *****************************
  # Create User
  # *****************************
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

  # *****************************
  # Create User's Tags
  # *****************************
  rand(1..4).times do
    Tag.create(user_id: new_user.id, name: Faker::StarWars.planet)
  end

  rand(1..2).times do
    Tag.create(user_id: new_user.id, name: Faker::StarWars.droid)
  end


  # *****************************
  # Create User's Experiences w/tags
  # *****************************
  rand(1..3).times do
    asset = Experience.create(
      company: Faker::Company.name,
      title: Faker::Company.profession,
      begin_date: Faker::Date.between(5.years.ago, Date.today),
      end_date: Faker::Date.between(5.years.ago, Date.today),
      description: Faker::Company.bs,
      location: Faker::Address.city,
      user_id: new_user.id)
    rand(1..(new_user.tags.count)).times do
      asset.tags << new_user.tags.sample
    end
    rand(1..7).times do
      description = Description.create(detail: Faker::Company.bs)
      asset.descriptions << description
    end
  end


  # *****************************
  # Create User's Volunteering w/tags
  # *****************************
  rand(1..3).times do
    asset = Volunteering.create(
      organization: Faker::Company.name,
      title: Faker::Company.profession,
      begin_date: Faker::Date.between(5.years.ago, Date.today),
      end_date: Faker::Date.between(5.years.ago, Date.today),
      description: Faker::Company.bs,
      location: Faker::Address.city,
      user_id: new_user.id)
    rand(1..(new_user.tags.count)).times do
      asset.tags << new_user.tags.sample
    end
    rand(1..7).times do
      description = Description.create(detail: Faker::Company.bs)
      asset.descriptions << description
    end
  end


  # *****************************
  # Create User's Educations w/tags
  # *****************************
  rand(1..3).times do
    asset = Education.create(
      institution_name: Faker::University.name,
      completion: Faker::Date.between(5.years.ago, Date.today),
      description: Faker::Company.bs,
      focus: "Studies",
      location: Faker::Address.city,
      user_id: new_user.id)
    rand(1..(new_user.tags.count)).times do
      asset.tags << new_user.tags.sample
    end
    rand(1..7).times do
      description = Description.create(detail: Faker::Company.buzzword)
      asset.descriptions << description
    end
  end

  # *****************************
  # Create User's Objectives w/tags
  # *****************************
  rand(1..3).times do
    asset = Objective.create(
      description: Faker::Company.bs,
      user_id: new_user.id)
    rand(1..(new_user.tags.count)).times do
      asset.tags << new_user.tags.sample
    end
    rand(1..7).times do
      description = Description.create(detail: Faker::Company.catch_phrase)
      asset.descriptions << description
    end
  end


  # *****************************
  # Create User's Skills w/tags
  # *****************************
  rand(1..3).times do
    asset = Skill.create(
      title: Faker::Company.buzzword,
      user_id: new_user.id)
    rand(1..(new_user.tags.count)).times do
      asset.tags << new_user.tags.sample
    end
    rand(1..7).times do
      description = Description.create(detail: Faker::Company.profession)
      asset.descriptions << description
    end
  end

  # *****************************
  # Create User's Projects w/tags
  # *****************************
  rand(1..3).times do
    asset = Project.create(
      title: Faker::Hacker.ingverb,
      description: Faker::Hacker.say_something_smart,
      user_id: new_user.id)
    rand(1..(new_user.tags.count)).times do
      asset.tags << new_user.tags.sample
    end
    rand(1..7).times do
      description = Description.create(detail: Faker::Commerce.product_name)
      asset.descriptions << description
    end
  end

  # *****************************
  # Create User's Resume w/tags
  # *****************************
  new_resume = Resume.create(target_job: Faker::Company.profession, user_id: new_user.id)
  rand(1..(new_user.tags.count)).times do
    new_resume.tags << new_user.tags.sample
  end

  # *****************************
  # Create Resume Assets
  # *****************************
  2.times do
    new_resume.experiences << new_user.experiences.sample
    new_resume.objectives << new_user.objectives.sample
    new_resume.projects << new_user.projects.sample
    new_resume.skills << new_user.skills.sample
    new_resume.educations << new_user.educations.sample
    new_resume.volunteerings << new_user.volunteerings.sample
  end

end

puts "New Users Summary:"
puts "******************"
User.all.each do |user|
  puts "#{user.first_name} #{user.last_name} (#{user.email})"
  # puts
  # puts "Websites:"
  # puts "*********"
  # user.websites.each do |site|
  #   puts "#{site.description}: #{site.url}"
  # end
  # puts
  # puts "Tags:"
  # puts "*****"
  # user.tags.each do |tag|
  #   puts "#{tag.name}"
  # end
end

